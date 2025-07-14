import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FirebaseConfigRefreshed extends Equatable {
  final Color? floatActionButtonColor;
  const FirebaseConfigRefreshed({this.floatActionButtonColor});

  @override
  List<Object?> get props => [floatActionButtonColor];

  FirebaseConfigRefreshed copyWith({Color? floatActionButtonColor}) {
    return FirebaseConfigRefreshed(
      floatActionButtonColor:
          floatActionButtonColor ?? this.floatActionButtonColor,
    );
  }
}
