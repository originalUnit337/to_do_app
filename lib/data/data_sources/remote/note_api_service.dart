import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:to_do_app/core/constants/constants.dart';
import 'package:to_do_app/data/api/model/collection_model.dart';
import 'package:to_do_app/data/api/model/database_version_model.dart';
import 'package:to_do_app/data/api/model/document_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';

part 'note_api_service.g.dart';

@RestApi(baseUrl: noteAPIBaseURL)
abstract class NoteApiService {
  factory NoteApiService(Dio dio) = _NoteApiService;

  // ! notes methods

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
    @Query('documentId') String? documentId,
  });

  @DELETE('$notesCollection/{id}')
  Future<HttpResponse<void>> deleteNote(
    @Path('id') String id, {
    @Query('key') String? apiKey = apiKey,
  });

  // ! db_version methods
  // TODO: replace db_version methods to another file (e.g. database_version_service.dart)

  @GET(databaseVersionCollection)
  Future<HttpResponse<CollectionModel<DatabaseVersionModel>>>
  getDatabaseVersion({@Query('key') String? apiKey = apiKey});

  @PATCH('$databaseVersionCollection/{id}')
  Future<HttpResponse<void>> updateDatabaseVersion(
    @Path('id') String id,
    @Body() DatabaseVersionModel databaseModel, {
    @Query('key') String? apiKey = apiKey,
  });

  @POST('$databaseVersionCollection/{collectionId}')
  Future<HttpResponse<DocumentModel<DatabaseVersionModel>>>
  createDataBaseVersion(
    @Path('collectionId') String collectionId,
    @Body() DatabaseVersionModel databaseVersion, {
    @Query('key') String? apiKey = apiKey,
    @Query('documentId') String? documentId,
  });

  @DELETE('$databaseVersionCollection/{id}')
  Future<HttpResponse<void>> deleteDatabaseVersion(
    @Path('id') String id, {
    @Query('key') String? apiKey = apiKey,
  });
}
