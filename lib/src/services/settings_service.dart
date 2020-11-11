import 'package:flutter/foundation.dart';
import 'package:obs_countdown_timer/src/models/preferences.dart';

class SettingsService extends ChangeNotifier {
  // Create preferences model with default
  PreferencesModel _preferencesModel = PreferencesModel();

  // Expose model since it's internal
  PreferencesModel get preferencesModel => _preferencesModel;
}
