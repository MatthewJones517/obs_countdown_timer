import 'package:flutter/material.dart';

class Preferences {
  /// Either 'chroma' or 'luma'. Chroma will give the screen a green background.
  /// Luma will give it a black background
  final String maskingKeyStyle;

  /// Google Font Name. Not all Google fonts are supported.
  final String googleFontName;

  /// The font size of the timer
  final String timerFontSize;

  /// The color or the timer
  final Color timerColor;

  /// Font Stroke Size
  final int timerStrokeSize;

  /// Font Stroke Color
  final Color timerStrokeColor;

  Preferences(
      {this.maskingKeyStyle,
      this.googleFontName,
      this.timerFontSize,
      this.timerColor,
      this.timerStrokeSize,
      this.timerStrokeColor});
}
