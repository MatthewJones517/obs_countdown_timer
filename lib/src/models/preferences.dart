import 'package:flutter/material.dart';

class PreferencesModel {
  /// If set to true Chroma will be used. Otherwise Luma will be used.
  final Color keyType;

  /// Google Font Name. Not all Google fonts are supported.
  final String googleFontName;

  /// The font size of the timer
  final double timerFontSize;

  /// The color or the timer
  final Color timerColor;

  final String finishedMessage;

  /// Builds with passed in settings
  PreferencesModel(
      {this.keyType,
      this.googleFontName,
      this.timerFontSize,
      this.timerColor,
      this.finishedMessage});

  /// Builds with default settings
  PreferencesModel.withDefaults()
      : keyType = KeyType.luma,
        googleFontName = 'Raleway',
        timerFontSize = 72,
        timerColor = Colors.white,
        finishedMessage = "We'll get started shortly!";
}

class KeyType {
  static const Color luma = Color(0xFF000000);
  static const Color chroma = Color(0xFF00b140);
}
