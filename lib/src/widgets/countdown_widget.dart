import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:obs_countdown_timer/src/services/settings_service.dart';

class CountdownWidget extends StatelessWidget {
  Widget build(context) {
    return Consumer<SettingsService>(
        builder: (context, settingsService, child) {
      return Container(
        color: settingsService.preferences.keyType,
        child: Center(
          child: Text(
            '00:00',
            style: GoogleFonts.getFont(
              settingsService.preferences.googleFontName,
              textStyle: TextStyle(
                  color: settingsService.preferences.timerColor,
                  fontSize: settingsService.preferences.timerFontSize),
            ),
          ),
        ),
      );
    });
  }
}
