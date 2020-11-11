import 'package:flutter/material.dart';
import 'package:obs_countdown_timer/src/widgets/countdown_widget.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [CountdownWidget()],
      ),
    );
  }
}
