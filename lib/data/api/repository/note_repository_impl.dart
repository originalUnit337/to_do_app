import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/data/mapper/note_mapper.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteApiService _noteApiService;
  NoteRepositoryImpl(this._noteApiService);
  @override
  Future<DataState<List<NoteEntity>>> getAllNotes() async {
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
  }

  @override
  Future<DataState<bool>> updateNote(NoteEntity note) async {
    try {
      final httpResponse = await _noteApiService.updateNote(
        note.id.split('/').last,
        note.toJson(),
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
  }
}
