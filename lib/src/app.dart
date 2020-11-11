import 'package:flutter/material.dart';
import 'package:obs_countdown_timer/src/screens/settings.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Countdown Timer Overlay',
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}
