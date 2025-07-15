import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FirebaseConfigState extends Equatable {
  final Color? floatActionButtonColor;
  const FirebaseConfigState({this.floatActionButtonColor});

  @override
  List<Object?> get props => [floatActionButtonColor];

  FirebaseConfigState copyWith({Color? floatActionButtonColor}) {
    return FirebaseConfigState(
      floatActionButtonColor:
          floatActionButtonColor ?? this.floatActionButtonColor,
    );
  }
}
