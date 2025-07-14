import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/common/helpers/extensions/color_ext.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_event.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_state.dart';

class FirebaseConfigBloc
    extends Bloc<FirebaseConfigEvent, FirebaseConfigState> {
  final FirebaseRemoteConfig _remoteConfig;
  Timer? _timer;

  FirebaseConfigBloc()
    : _remoteConfig = FirebaseRemoteConfig.instance,
      super(const FirebaseConfigState()) {
    _init();
    on<RefreshFirebaseConfigEvent>(_refreshFirebaseConfig);
  }

  void _init() {
    debugPrint('\n\n\nСоздание FirebaseConfigBloc\n\n\n');
    _remoteConfig
      ..setDefaults({'floatActionButtonColour': '#007AFF'})
      ..setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
    try {
      _remoteConfig.fetchAndActivate();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const RefreshFirebaseConfigEvent());
    });
  }

  FutureOr<void> _refreshFirebaseConfig(
    RefreshFirebaseConfigEvent event,
    Emitter<FirebaseConfigState> emit,
  ) {
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
      debugPrint('Emitting...');
      emit(
        FirebaseConfigState(
          floatActionButtonColor: ColorExt.fromHex(
            _remoteConfig.getString('floatActionButtonColour'),
          ),
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
