import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_event.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_state.dart';

class FirebaseConfigBloc
    extends Bloc<FirebaseConfigEvent, FirebaseConfigState> {
  final FirebaseRemoteConfig _remoteConfig;
  Timer? _timer;

  FirebaseConfigBloc({FirebaseRemoteConfig? remoteConfig})
    : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance,
      super(const FirebaseConfigInitial()) {
    debugPrint('\n\n\nСоздание FirebaseConfigBloc\n\n\n');
    _remoteConfig.setDefaults({'floatActionButtonColour': '#007AFF'});
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
      debugPrint('fetching...');
      try {
        unawaited(
          _remoteConfig.fetchAndActivate().then((result) {
            if (result) {
              debugPrint('Success');
              final floatActionButtonColor = _remoteConfig.getString(
                'floatActionButtonColour',
              );
              debugPrint(floatActionButtonColor);
            } else {
              debugPrint('Failed');
            }
          }, onError: (e) => debugPrint(e.toString())),
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
      //GetIt.I.registerSingleton<FirebaseRemoteConfig>(_remoteConfig);
      emit(
        FirebaseConfigRefreshed(
          floatActionButtonColor: _colorFromHex(
            _remoteConfig.getString('floatActionButtonColour'),
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Color _colorFromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
  }
}
