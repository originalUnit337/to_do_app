import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/api/repository/note_repository_impl.dart';
import 'package:to_do_app/data/data_sources/remote/note_api_service.dart';
import 'package:to_do_app/domain/repository/note_repository.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<NoteApiService>(NoteApiService(sl()))
    ..registerSingleton<NoteRepository>(NoteRepositoryImpl(sl()))
    ..registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(sl()))
    ..registerFactory<HomeScreenBloc>(() => HomeScreenBloc(sl()));
}
