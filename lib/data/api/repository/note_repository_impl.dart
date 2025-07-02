import 'dart:io';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:to_do_app/core/constants/constants.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/data/api/model/database_version_model.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/data/data_sources/local/note_local_service.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/data/mapper/note_mapper.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteApiService _noteApiService;
  final NoteLocalService _noteLocalService;
  NoteRepositoryImpl(this._noteApiService, this._noteLocalService);
  @override
  Future<DataState<List<NoteEntity>>> getAllNotes() async {
    if (await InternetConnection().hasInternetAccess) {
      try {
        final httpResponse = await _noteApiService.getAllNotes();

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          final notes =
              httpResponse.data.documents
                  .map((doc) => NoteMapper.toEntity(doc.fields))
                  .toList();
          return DataSuccess(notes);
        } else {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      try {
        final notes = await _noteLocalService.getAllNotes();
        return DataSuccess(notes.map(NoteMapper.fromLocalToEntity).toList());
      } on Exception {
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message:
                'Local DB getAllNotes exception: something went wrong, note_repository_impl.dart',
          ),
        );
      }
    }
  }

  Future<void> _updateDatabaseVersion() async {
    await _noteApiService.updateDatabaseVersion(
      databaseVersionId,
      DatabaseVersionModel(DateTime.now(), databaseVersionId),
    );
  }

  @override
  Future<DataState<bool>> updateNote(NoteEntity note) async {
    if (await InternetConnection().hasInternetAccess) {
      try {
        final httpResponse = await _noteApiService.updateNote(
          note.id.split('/').last,
          NoteMapper.toModel(note),
        );
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          await _updateDatabaseVersion();
          return const DataSuccess(true);
        } else {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      try {
        if (await _noteLocalService.updateNote(NoteMapper.toLocal(note))) {
          return const DataSuccess(true);
        } else {
          return const DataSuccess(false);
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<NoteEntity>> createNote(NoteEntity note) async {
    if (await InternetConnection().hasInternetAccess) {
      try {
        final httpResponse = await _noteApiService.createNote(
          '',
          NoteMapper.toModel(note),
        );
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          await _updateDatabaseVersion();

          return DataSuccess(NoteMapper.toEntity(httpResponse.data.fields));
        } else {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      try {
        final createdNote = NoteMapper.toLocal(
          note,
        ).copyWith(id: DateTime.now().toIso8601String());
        if (await _noteLocalService.createNote(createdNote) > 0) {
          return DataSuccess(NoteMapper.fromLocalToEntity(createdNote));
        } else {
          throw Exception('Something went wrong');
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  Future<DataState<bool>> deleteNote(NoteEntity note) async {
    if (await InternetConnection().hasInternetAccess) {
      try {
        final httpResponse = await _noteApiService.deleteNote(
          note.id.split('/').last,
        );
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          await _updateDatabaseVersion();

          return const DataSuccess(true);
        } else {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      try {
        if (await _noteLocalService.deleteNote(NoteMapper.toLocal(note))) {
          return const DataSuccess(true);
        } else {
          return const DataSuccess(false);
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<bool>> syncNotes() async {
    if (await InternetConnection().hasInternetAccess) {
      try {
        final localNotes = await _noteLocalService.getAllNotes();
        var localDatabaseVersion = DatabaseVersion(id: 1, version: DateTime(0));

        try {
          localDatabaseVersion = await _noteLocalService.getDatabaseVersion();
        } on StateError {}

        final remoteVersionResponse =
            await _noteApiService.getDatabaseVersion();
        DatabaseVersionModel remoteDatabaseVersion;

        final httpResponse = await _noteApiService.getAllNotes();
        var remoteNotes = <DocumentModel<NoteModel>>[];

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          remoteNotes = httpResponse.data.documents;
        }

        if (remoteVersionResponse.response.statusCode == HttpStatus.ok) {
          if (localNotes.isEmpty && remoteNotes.isEmpty) {
            return const DataSuccess(true);
          }

          if (localNotes.isEmpty) {
            for (final remoteNote in remoteNotes) {
              try {
                await _noteLocalService.createNote(
                  NoteMapper.toLocal(remoteNote.fields),
                );
              } on Exception catch (e) {
                rethrow;
              }
            }
            return const DataSuccess(true);
          }

          if (remoteNotes.isEmpty) {
            for (final localNote in localNotes) {
              await _noteApiService.createNote(
                '',
                NoteMapper.toModel(
                  NoteMapper.fromLocalToEntity(localNote.copyWith(id: '')),
                ),
              );
            }
            return const DataSuccess(true);
          }
          remoteDatabaseVersion =
              remoteVersionResponse.data.documents.first.fields;

          // ! local_db newer
          if (localDatabaseVersion.version.isAfter(
            remoteDatabaseVersion.version,
          )) {
            for (final e in remoteNotes) {
              await _noteApiService.deleteNote(e.fields.id.split('/').last);
            }
            for (final localNote in localNotes) {
              await _noteApiService.createNote(
                '',
                NoteMapper.toModel(
                  NoteMapper.fromLocalToEntity(localNote.copyWith(id: '')),
                ),
              );
            }
            await _noteApiService.updateDatabaseVersion(
              databaseVersionId,
              DatabaseVersionModel(
                localDatabaseVersion.version,
                databaseVersionId,
              ),
            );
            // ! remote_db newer
          } else if (remoteDatabaseVersion.version.isAfter(
            localDatabaseVersion.version,
          )) {
            for (final e in localNotes) {
              await _noteLocalService.deleteNote(e);
            }
            for (final remoteNote in remoteNotes) {
              await _noteLocalService.createNote(
                NoteMapper.toLocal(remoteNote.fields),
              );
            }
            await _noteLocalService.setDatabaseVersion(
              remoteDatabaseVersion.version,
            );
          }
        }

        return const DataSuccess(true);
      } catch (e) {
        // ignore: avoid_print
        print(e);
        rethrow;
      }
    } else {
      return const DataSuccess(false);
    }
  }
}
