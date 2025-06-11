import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final GetAllNotesUseCase _getAllNotesUseCase;
  HomeScreenBloc(this._getAllNotesUseCase) : super(const NotesInitial()) {
    on<GetAllNotesEvent>(_getAllNotes);
  }

  Future<void> _getAllNotes(
    GetAllNotesEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    final dataState = await _getAllNotesUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(NotesLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(NotesError(dataState.exception!));
    }
  }
}
