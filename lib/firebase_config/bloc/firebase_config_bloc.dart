import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'package:to_do_app/core/common/helpers/extensions/color_ext.dart';
import 'package:to_do_app/core/common/log/good_log.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_event.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_state.dart';

class FirebaseConfigBloc
    extends Bloc<FirebaseConfigEvent, FirebaseConfigState> {
  final FirebaseRemoteConfig _remoteConfig;
  final Talker _talker = Talker(settings: TalkerSettings());
  Timer? _timer;

  FirebaseConfigBloc()
    : _remoteConfig = FirebaseRemoteConfig.instance,
      super(const FirebaseConfigState()) {
    _init();
    on<RefreshFirebaseConfigEvent>(_refreshFirebaseConfig);
  }

  Future<void> _init() async {
    _talker.log('Creating FirebaseConfigBloc...');
    await _remoteConfig.setDefaults({'floatActionButtonColour': '#007AFF'});
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );
    try {
      await _remoteConfig.fetchAndActivate();
      add(const RefreshFirebaseConfigEvent());
    } on Exception catch (e, st) {
      _talker.handle(e, st);
    }
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const RefreshFirebaseConfigEvent());
    });
  }

  FutureOr<void> _refreshFirebaseConfig(
    RefreshFirebaseConfigEvent event,
    Emitter<FirebaseConfigState> emit,
  ) {
    _talker.log('Fetching Firebase config...');
    try {
      unawaited(
        _remoteConfig.fetchAndActivate().then((result) {
          if (result) {
            _talker.logCustom(GoodLog('Successfully fetched Firebase config'));
            final floatActionButtonColor = _remoteConfig.getString(
              'floatActionButtonColour',
            );
            _talker.info(
              'received floatActionButtonColor from Firebase config: $floatActionButtonColor',
            );
          } else {
            _talker.warning('FAILED: Firebase config fetching.');
          }
        }, onError: (e) => _talker.handle(e.toString())),
      );
      _talker.log('Emitting FirebaseConfigState...');
      emit(
        FirebaseConfigState(
          floatActionButtonColor: ColorExt.fromHex(
            _remoteConfig.getString('floatActionButtonColour'),
          ),
        ),
      );
    } on Exception catch (e, st) {
      _talker.handle(e, st);
    }
  }
}
