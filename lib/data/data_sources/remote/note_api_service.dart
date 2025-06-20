import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:to_do_app/core/constants/constants.dart';
import 'package:to_do_app/data/api/model/collection_model.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';

part 'note_api_service.g.dart';

@RestApi(baseUrl: noteAPIBaseURL)
abstract class NoteApiService {
  factory NoteApiService(Dio dio) = _NoteApiService;

  @GET(notesCollection)
  Future<HttpResponse<CollectionModel<NoteModel>>> getAllNotes({
    @Query('key') String? apiKey = apiKey,
  });

  @PATCH('$notesCollection/{id}')
  Future<HttpResponse<void>> updateNote(
    @Path('id') String id,
    @Body() NoteModel note, {
    @Query('key') String? apiKey = apiKey,
  });

  @POST('$notesCollection/{collectionId}')
  Future<HttpResponse<DocumentModel<NoteModel>>> createNote(
    @Path('collectionId') String collectionId,
    @Body() NoteModel note, {
    @Query('key') String? apiKey = apiKey,
  });

  @DELETE('$notesCollection/{id}')
  Future<HttpResponse<void>> deleteNote(
    @Path('id') String id, {
    @Query('key') String? apiKey = apiKey,
  });
}
