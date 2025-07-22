import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:talker/talker.dart';
import 'package:to_do_app/core/common/log/good_log.dart';
import 'package:to_do_app/core/resources/data_state.dart';
import 'package:to_do_app/domain/usecases/delete_note.dart';
import 'package:to_do_app/domain/usecases/get_all_notes.dart';
import 'package:to_do_app/domain/usecases/sync_note.dart';
import 'package:to_do_app/domain/usecases/update_note.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final Talker _talker;
  final GetAllNotesUseCase _getAllNotesUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;
  final SyncNoteUseCase _syncNoteUseCase;
  late StreamSubscription<InternetStatus> _internetStatusSubscription;
  HomeScreenBloc(
    this._getAllNotesUseCase,
    this._updateNoteUseCase,
    this._deleteNoteUseCase,
    this._syncNoteUseCase,
    this._talker,
  ) : super(const NotesInitial()) {
    _talker.log('Creating HomeScreenBloc');
    _startListeningToInternt();
    on<InternetConnectedEvent>(_internetConnected);
    on<InternetDisconnectedEvent>(_internetDisconnected);
    on<GetAllNotesEvent>(_getAllNotes);
    on<ToggleNoteCompletion>(_toggleNoteCompletion);
    on<ToggleShowCompleted>(_toggleShowCompleted);
    on<RefreshNotesEvent>(_refreshNoteEvent);
    on<DeleteNoteEvent>(_deleteNote);
  }

  void _startListeningToInternt() {
    _talker.log('Start listening to InternetConnection stream...');
    _internetStatusSubscription = InternetConnection().onStatusChange.listen((
      status,
    ) {
      switch (status) {
        case InternetStatus.connected:
          _talker.warning(
            'Internet connected. Emiting InternetConnectionEvent',
          );
          add(InternetConnectedEvent());
        case InternetStatus.disconnected:
          _talker.warning(
            'Internet disconnected. Emiting InternetDisconnectedEvent',
          );
          add(InternetDisconnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    _internetStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _getAllNotes(
    GetAllNotesEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Geting All Notes...');
    unawaited(analytics.logEvent(name: 'bloc_getAllNotes'));
    final notesData = await _getAllNotesUseCase();
    emit(const NotesLoading());
    final syncResult = await _syncNoteUseCase();
    if (notesData is DataSuccess && notesData.data != null) {
      _talker.logCustom(
        GoodLog('[HOME_SCREEN_BLOC EVENT HANDLER] SUCCESS Geting all notes'),
      );
      if (syncResult.data ?? false) {
        _talker.logCustom(
          GoodLog('[HOME_SCREEN_BLOC EVENT HANDLER] SUCCESS Syncing all notes'),
        );
        emit(NotesLoaded(notesData.data!, isSync: true));
      } else {
        _talker.warning(
          '[HOME_SCREEN_HANDLER] Failed syncing notes between local and remote databases',
        );
        emit(NotesLoaded(notesData.data!, isSync: false));
      }
    } else {
      if (notesData is DataFailed) {
        _talker.error('[HOME_SCREEN_HANDLER] ERROR getting all notes');
        emit(NotesError(notesData.exception!));
      }
    }
  }

  FutureOr<void> _toggleNoteCompletion(
    ToggleNoteCompletion event,
    Emitter<HomeScreenState> emit,
  ) async {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Toggling note completion...');
    unawaited(analytics.logEvent(name: 'bloc_toggleNoteCompletion'));
    final currentState = state;
    if (currentState is NotesLoaded) {
      final response = await _updateNoteUseCase(
        params: event.note.copyWith(isCompleted: !event.note.isCompleted),
      );
      if (response.data ?? false) {
        final updatedNotes =
            currentState.notes?.map((note) {
              if (note == event.note) {
                return note.copyWith(isCompleted: !note.isCompleted);
              }
              return note;
            }).toList();
        if (updatedNotes != null) {
          _talker.logCustom(
            GoodLog(
              '[HOME_SCREEN_BLOC EVENT HANDLER] SUCCESS togling note completion',
            ),
          );
          emit(
            NotesLoaded(
              updatedNotes,
              showCompleted: currentState.showCompleted,
              isUpdated: response.data,
            ),
          );
        }
      } else {
        _talker.error(
          '[HOME_SCREEN_BLOC EVENT HANDLER] ERROR toggling note completion',
        );
        emit(
          NotesError(
            response.exception ??
                DioException(
                  requestOptions: RequestOptions(),
                  error: 'something really went wrong',
                ),
          ),
        );
      }
    }
  }

  FutureOr<void> _toggleShowCompleted(
    ToggleShowCompleted event,
    Emitter<HomeScreenState> emit,
  ) {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Toggling show completed...');
    analytics.logEvent(name: 'bloc_toggleShowCompleted');
    if (state is NotesLoaded) {
      emit(NotesLoaded(state.notes ?? [], showCompleted: !state.showCompleted));
    }
  }

  FutureOr<void> _refreshNoteEvent(
    RefreshNotesEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Refresh note event...');
    analytics.logEvent(name: 'bloc_refreshNoteEvent');
    if (state is NotesLoaded) {
      emit(const NotesLoading());
      emit(NotesLoaded(event.notes, showCompleted: state.showCompleted));
    }
  }

  FutureOr<void> _deleteNote(
    DeleteNoteEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Deleting note...');
    unawaited(analytics.logEvent(name: 'bloc_deleteNote'));
    final currentState = state;
    if (currentState is NotesLoaded) {
      final response = await _deleteNoteUseCase(params: event.note);
      if (response.data ?? false) {
        currentState.notes?.remove(event.note);
        final updatedNotes = currentState.notes;
        if (updatedNotes != null) {
          _talker.logCustom(
            GoodLog('[HOME_SCREEN_BLOC EVENT HANDLER] SUCCESS Deleting note'),
          );
          emit(
            NotesLoaded(
              updatedNotes,
              showCompleted: currentState.showCompleted,
              isUpdated: response.data,
            ),
          );
        }
      } else {
        _talker.error('[HOME_SCREEN_BLOC EVENT HANDLER] ERROR Deleting note');
        emit(
          NotesError(
            response.exception ??
                DioException(
                  requestOptions: RequestOptions(),
                  error: 'something really went wrong',
                ),
          ),
        );
      }
    }
  }

  FutureOr<void> _internetConnected(
    InternetConnectedEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Internet connected...');
    unawaited(analytics.logEvent(name: 'bloc_internetConnected'));
    final syncResult = await _syncNoteUseCase();
    if (syncResult.data ?? false) {
      _talker.logCustom(
        GoodLog('[HOME_SCREEN_BLOC EVENT HANDLER] SUCCESS data syncronized '),
      );
      emit(NotesLoaded(state.notes ?? [], isSync: true));
    } else {
      _talker.error('[HOME_SCREEN_BLOC EVENT HANDLER] FAILED syncronization');
      emit(NotesLoaded(state.notes ?? [], isSync: false));
    }
  }

  FutureOr<void> _internetDisconnected(
    InternetDisconnectedEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    _talker.log('[HOME_SCREEN_BLOC EVENT HANDLER] Internet Disconnected');
    unawaited(analytics.logEvent(name: 'bloc_internetDisconnected'));
    emit(NotesLoaded(state.notes ?? [], isSync: false));
  }
}
