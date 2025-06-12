import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:to_do_app/core/constants/constants.dart';
import 'package:to_do_app/data/api/model/collection_model.dart';
import 'package:to_do_app/data/api/model/note_model.dart';

part 'note_api_service.g.dart';

@RestApi(baseUrl: noteAPIBaseURL)
abstract class NoteApiService {
  factory NoteApiService(Dio dio) = _NoteApiService;

  @GET(notesCollection)
  Future<HttpResponse<CollectionModel<NoteModel>>> getAllNotes({
    @Query('key') String? apiKey = apiKey,
  });
}
