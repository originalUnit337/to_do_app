import 'package:flutter/material.dart';

abstract interface class Palette {
  // Support
  Color get supportSeparator;
  Color get supportOverlay;
  // Label
  Color get labelPrimary;
  Color get labelSecondary;
  Color get labelTertiary;
  Color get labelDisable;
  // Color
  Color get colorRed;
  Color get colorGreen;
  Color get colorBlue;
  Color get colorGray;
  Color get colorGrayLight;
  Color get colorWhite;
  // Back
  Color get backPrimary;
  Color get backSecondary;
  Color get backElevated;
}
