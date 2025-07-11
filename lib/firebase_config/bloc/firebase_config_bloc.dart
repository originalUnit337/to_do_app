import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_event.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_state.dart';

class FirebaseConfigBloc
    extends Bloc<FirebaseConfigEvent, FirebaseConfigState> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Timer? _timer;

  FirebaseConfigBloc() : super(const FirebaseConfigInitial()) {
    // ignore: avoid_print
    print('\n\n\nСоздание FirebaseConfigBloc\n\n\n');
    _remoteConfig.setDefaults({'floatActionButtonColour': '0xFF007AFF'});
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const RefreshFirebaseConfigEvent());
    });
    on<RefreshFirebaseConfigEvent>(_refreshFirebaseConfig);
  }

  FutureOr<void> _refreshFirebaseConfig(
    RefreshFirebaseConfigEvent event,
    Emitter<FirebaseConfigState> emit,
  ) async {
    try {
      emit(const FirebaseConfigRefreshing());
      // ignore: avoid_print
      print('fetching...');
      if (await _remoteConfig.fetchAndActivate()) {
        // ignore: avoid_print
        print('Success');
      } else {
        // ignore: avoid_print
        print('Failed');
      }
      //GetIt.I.registerSingleton<FirebaseRemoteConfig>(_remoteConfig);
      final floatActionButtonColor = _remoteConfig.getString(
        'floatActionButtonColour',
      );
      // ignore: avoid_print
      print(floatActionButtonColor);
      emit(const FirebaseConfigRefreshed());
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
