import 'package:flutter/material.dart';

class PreferencesModel {
  /// Either 'chroma' or 'luma'. Chroma will give the screen a green background.
  /// Luma will give it a black background
  final String maskingKeyStyle;

  /// Google Font Name. Not all Google fonts are supported.
  final String googleFontName;

  /// The font size of the timer
  final int timerFontSize;

  /// The color or the timer
  final Color timerColor;

  /// Font Stroke Size
  final int timerStrokeSize;

  /// Font Stroke Color
  final Color timerStrokeColor;

  final String finishedMessage;

  /// Builds with default settings
  PreferencesModel()
      : maskingKeyStyle = 'luma',
        googleFontName = 'ConcertOne',
        timerFontSize = 72,
        timerColor = Colors.white,
        timerStrokeSize = 5,
        timerStrokeColor = Colors.black,
        finishedMessage = "We'll get started shortly!";
}
