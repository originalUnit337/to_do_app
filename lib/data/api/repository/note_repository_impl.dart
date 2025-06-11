import 'dart:io';

import 'package:dio/dio.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/data/api/model/note_model.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteApiService _noteApiService;
  NoteRepositoryImpl(this._noteApiService);
  @override
  Future<DataState<List<NoteModel>>> getAllNotes() async {
    try {
      final httpResponse = await _noteApiService.getAllNotes();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final notes =
            httpResponse.data.documents.map((doc) => doc.fields).toList();
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
}
