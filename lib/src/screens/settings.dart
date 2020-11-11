import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_countdown_timer/src/services/settings_service.dart';
import 'package:obs_countdown_timer/src/widgets/countdown_widget.dart';
import 'package:obs_countdown_timer/src/models/preferences.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          CountdownWidget(),
          settingsPanel(),
        ],
      ),
    );
  }

  Widget settingsPanel() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      width: 425,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Consumer<SettingsService>(
        builder: (context, settingsService, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              settingsPanelHeader(),
              settingsPanelDescription(),
              settingsPanelKeyType(),
            ],
          );
        },
      ),
    );
  }

  Widget settingsPanelHeader() {
    return Text(
      'Simple OBS Timer Overlay',
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget settingsPanelDescription() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        "This is a super simple timer overlay for use with OBS. Just choose your settings below. Note that you'll need to key out the background using either Luma or Chroma key.",
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget settingsPanelKeyType() {
    return Consumer<SettingsService>(
      builder: (context, settingsService, child) {
        return DropdownButtonFormField(
          value: 'Luma',
          items: [
            DropdownMenuItem(
              value: 'Chroma',
              child: dropdownText('Chroma'),
            ),
            DropdownMenuItem(
              value: 'Luma',
              child: dropdownText('Luma'),
            ),
          ],
          onChanged: (String value) {
            if (value == 'Chroma') {
              settingsService.updateKeyType(KeyType.chroma);
            } else {
              settingsService.updateKeyType(KeyType.luma);
            }
          },
          decoration: InputDecoration(labelText: 'Key Type'),
        );
      },
    );
  }

  Widget dropdownText(String text) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(fontSize: 12),
      ),
    );
  }
}
