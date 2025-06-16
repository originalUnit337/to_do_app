import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/api/repository/note_repository_impl.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';

final getIt = GetIt.instance;

void initializeDependencies() {
  getIt.registerSingleton<Dio>(Dio());
  _initServices();
  _initRepositories();
  _initUseCases();
}

void _initServices() {
  getIt.registerSingleton<NoteApiService>(NoteApiService(getIt()));
}

void _initRepositories() {
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl(getIt()));
}

void _initUseCases() {
  getIt
    ..registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(getIt()))
    ..registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(getIt()));
}
