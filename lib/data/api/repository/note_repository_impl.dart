import 'dart:io';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:talker/talker.dart';
import 'package:to_do_app/core/common/log/good_log.dart';
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
  final Talker _talker = Talker(settings: TalkerSettings());
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
        _talker.handle(e);
        return DataFailed(e);
      }
    } else {
      _talker.debug('Trying to get notes from local db...');
      try {
        final notes = await _noteLocalService.getAllNotes();
        _talker.logCustom(GoodLog('Successfully get all notes from locale db'));
        return DataSuccess(notes.map(NoteMapper.fromLocalToEntity).toList());
      } on Exception catch (e, stacktrace) {
        _talker.handle(e, stacktrace);
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

  Future<void> _updateDatabaseVersion({DateTime? version}) async {
    _talker.debug('Enter updateDatabaseVersion method...');
    await _noteApiService.updateDatabaseVersion(
      databaseVersionId,
      DatabaseVersionModel(version ?? DateTime.now(), databaseVersionId),
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
      } on DioException catch (e, st) {
        _talker.handle(e, st);
        return DataFailed(e);
      }
    } else {
      _talker.debug('Trying to update local db note...');
      try {
        if (await _noteLocalService.updateNote(NoteMapper.toLocal(note))) {
          _talker.logCustom(GoodLog('Successfully locale note updated'));
          return const DataSuccess(true);
        } else {
          _talker.error("Note didn't updated");
          return const DataSuccess(false);
        }
      } on DioException catch (e) {
        _talker.handle(e);
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<NoteEntity>> createNote(NoteEntity note) async {
    _talker.debug('Enter createNote method');
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
      _talker.debug('Trying to create new local note...');
      try {
        final createdNote = NoteMapper.toLocal(
          note,
        ).copyWith(id: DateTime.now().toIso8601String());
        if (await _noteLocalService.createNote(createdNote) > 0) {
          _talker.logCustom(GoodLog('Successfully locale note created'));
          return DataSuccess(NoteMapper.fromLocalToEntity(createdNote));
        } else {
          _talker.error('error during creating new note in locale db');
          throw Exception('Something went wrong');
        }
      } catch (e) {
        _talker.error('error during creating new note in locale db');
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message:
                'Something went wrong: error during creating new note in locale db',
          ),
        );
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
          _talker.error("Note didn't deleted");
          return const DataSuccess(false);
        }
      } on DioException catch (e) {
        _talker.error('error during creating new note in locale db');
        return DataFailed(e);
      }
    }
  }

  @override
  Future<DataState<bool>> syncNotes() async {
    _talker.log('Entering syncNotes method...');
    if (await InternetConnection().hasInternetAccess) {
      try {
        _talker.warning('Trying to syncronized remote and locale db');
        final localNotes = await _noteLocalService.getAllNotes();
        var localDatabaseVersion = DatabaseVersion(id: 1, version: DateTime(0));

        // on case if there is (in local db) no row
        try {
          localDatabaseVersion = await _noteLocalService.getDatabaseVersion();
        } on StateError catch (e) {
          _talker.handle(e);
        }

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
          _talker
            ..log(
              'Local db version: ${localDatabaseVersion.version.toIso8601String()}',
            )
            ..log(
              'Remote db version: ${remoteDatabaseVersion.version.toIso8601String()}',
            );

          // ! local_db newer
          if (localDatabaseVersion.version.isAfter(
            remoteDatabaseVersion.version,
          )) {
            _talker.warning('Local db newer');
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
            await _updateDatabaseVersion(version: localDatabaseVersion.version);
            // ! remote_db newer
          } else if (remoteDatabaseVersion.version.isAfter(
            localDatabaseVersion.version,
          )) {
            _talker.warning('Remote db newer');
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
        _talker.error('Error during syncronization: $e');
        return DataFailed(
          DioException(
            requestOptions: RequestOptions(),
            message: 'Something went wrong: error during syncronization',
          ),
        );
      }
    } else {
      _talker.warning('Syncronization failed: no internet connection');
      return const DataSuccess(false);
    }
  }
}
