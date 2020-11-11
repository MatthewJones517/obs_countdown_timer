import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:obs_countdown_timer/src/services/settings_service.dart';

class CountdownWidget extends StatefulWidget {
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  String timeLeft;
  Timer updateTimer;

  Widget build(context) {
    return Consumer<SettingsService>(
        builder: (context, settingsService, child) {
      // If the timeleft variable is null, show zeros.
      timeLeft ??= "00:00";

      // If the updateTimer hasn't been initiated, set it up to update every second.
      updateTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // Get current DateTime
          final now = DateTime.now();

          // Get datetime for end time
          final endTime = DateTime(
              now.year,
              now.month,
              now.day,
              settingsService.preferences.endTime.hour,
              settingsService.preferences.endTime.minute);

          // Calculate the difference between the two.
          final Duration difference = endTime.difference(now);
          final int differenceInSeconds = difference.inSeconds;

          // Figure hout the hours, minutes, and seconds
          int hours;
          int minutes;
          int seconds;

          if (differenceInSeconds > 0) {
            hours = (differenceInSeconds / 3600).floor();
            minutes = ((differenceInSeconds - (hours * 3600)) / 60).floor();
            seconds = (differenceInSeconds - (hours * 3600) - (minutes * 60));

            // Assemble the display
            String newTime = "";

            if (hours >= 1) {
              if (hours < 10) {
                newTime += "0";
              }
              newTime += hours.toString() + ":";
            }

            if (minutes < 10) {
              newTime += "0";
            }

            newTime += minutes.toString() + ":";

            if (seconds < 10) {
              newTime += "0";
            }

            newTime += seconds.toString();

            timeLeft = newTime;
          } else {
            timeLeft = "00:00";
          }
        });
      });

      return GestureDetector(
        onDoubleTap: () {
          settingsService.openSettingsPanel();
        },
        child: Container(
          color: settingsService.preferences.keyType,
          child: Center(
            child: Text(
              timeLeft,
              style: GoogleFonts.getFont(
                settingsService.preferences.googleFontName,
                textStyle: TextStyle(
                    color: settingsService.preferences.timerColor,
                    fontSize: settingsService.preferences.timerFontSize),
              ),
            ),
          ),
        ),
      );
    });
  }
}
