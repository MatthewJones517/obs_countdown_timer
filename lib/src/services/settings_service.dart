import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:obs_countdown_timer/src/models/preferences.dart';

class SettingsService extends ChangeNotifier {
  // Create preferences model with default
  PreferencesModel _preferencesModel = PreferencesModel.withDefaults();

  // Expose model since it's internal
  PreferencesModel get preferences => _preferencesModel;

  /// Changes key between luna / chroma
  void updateKeyType(Color keyType) {
    _updatePreferencesModel(keyType: keyType);
  }

  /// Updates google font name
  void updateGoogleFontName(String googleFontName) {
    _updatePreferencesModel(googleFontName: googleFontName);
  }

  /// Updates timer font size
  void updateTimerFontSize(int timerFontSize) {
    _updatePreferencesModel(timerFontSize: timerFontSize);
  }

  /// Updates timer font color
  void updateTimerFontColor(Color timerColor) {
    _updatePreferencesModel(timerColor: timerColor);
  }

  /// Updates timer stroke size
  void updateTimerStrokeSize(int timerStrokeSize) {
    _updatePreferencesModel(timerStrokeSize: timerStrokeSize);
  }

  /// Updates timer stroke color
  void updateTimerStrokColor(Color timerStrokeColor) {
    _updatePreferencesModel(timerStrokeColor: timerStrokeColor);
  }

  /// Updates message to display upon timer completion
  void updateFinishedMessage(String finishedMessage) {
    _updatePreferencesModel(finishedMessage: finishedMessage);
  }

  // Updates the preferences model
  void _updatePreferencesModel({
    Color keyType,
    String googleFontName,
    int timerFontSize,
    Color timerColor,
    int timerStrokeSize,
    Color timerStrokeColor,
    String finishedMessage,
  }) {
    _preferencesModel = PreferencesModel(
        keyType: keyType ?? _preferencesModel.keyType,
        googleFontName: googleFontName ?? _preferencesModel.googleFontName,
        timerFontSize: timerFontSize ?? _preferencesModel.timerFontSize,
        timerColor: timerColor ?? _preferencesModel.timerColor,
        timerStrokeSize: timerStrokeSize ?? _preferencesModel.timerStrokeSize,
        timerStrokeColor:
            timerStrokeColor ?? _preferencesModel.timerStrokeColor,
        finishedMessage: finishedMessage ?? _preferencesModel.finishedMessage);

    // Notify any listeners to this service that the preferences model has been updated.
    notifyListeners();
  }
}
