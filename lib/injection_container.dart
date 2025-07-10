import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:to_do_app/data/api/repository/note_repository_impl.dart';
import 'package:to_do_app/data/data_sources/local/note_local_service.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';
import 'package:to_do_app/domain/usecases/create_note.dart';
import 'package:to_do_app/domain/usecases/delete_note.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/domain/usecases/sync_note.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';

final getIt = GetIt.instance;

void initializeDependencies() {
  getIt.registerSingleton<Dio>(
    Dio()
      ..interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(printResponseData: false),
        ),
      ),
  );
  Bloc.observer = TalkerBlocObserver(
    settings: const TalkerBlocLoggerSettings(
      printChanges: true,
      printClosings: true,
      printCreations: true,
    ),
  );
  _initServices();
  _initRepositories();
  _initUseCases();
}

void _initServices() {
  getIt
    ..registerSingleton<NoteApiService>(NoteApiService(getIt()))
    ..registerSingleton<NoteLocalService>(NoteLocalService());
}

void _initRepositories() {
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl(getIt(), getIt()));
}

void _initUseCases() {
  getIt
    ..registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(getIt()))
    ..registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(getIt()))
    ..registerSingleton<CreateNoteUseCase>(CreateNoteUseCase(getIt()))
    ..registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(getIt()))
    ..registerSingleton<SyncNoteUseCase>(SyncNoteUseCase(getIt()));
}
