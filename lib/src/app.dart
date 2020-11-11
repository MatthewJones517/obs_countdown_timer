import 'package:flutter/material.dart';
import 'package:obs_countdown_timer/src/screens/screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Countdown Timer Overlay',
      debugShowCheckedModeBanner: false,
      home: Screen(),
    );
  }
}
