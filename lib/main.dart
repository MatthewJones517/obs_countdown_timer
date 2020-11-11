import 'package:flutter/material.dart';
import 'package:obs_countdown_timer/src/app.dart';
import 'package:obs_countdown_timer/src/services/settings_service.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsService(),
        ),
      ],
      child: App(),
    ),
  );
}
