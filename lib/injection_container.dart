import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/api/repository/note_repository_impl.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<Dio>(Dio());
  _initialServices(getIt);
  _initialRepositories(getIt);
  _initialUseCases(getIt);
}

void _initialServices(GetIt sl) {
  sl.registerSingleton<NoteApiService>(NoteApiService(sl()));
}

void _initialRepositories(GetIt sl) {
  sl.registerSingleton<NoteRepository>(NoteRepositoryImpl(sl()));
}

void _initialUseCases(GetIt sl) {
  sl.registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(sl()));
}
