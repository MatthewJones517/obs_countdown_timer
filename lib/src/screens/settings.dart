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
              settingsPanelKeyType(settingsService),
              settingsPanelFontSelection(settingsService),
              fontSizeSelector(settingsService)
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

  Widget settingsPanelKeyType(SettingsService settingsService) {
    return DropdownButtonFormField(
      value: 'Luma',
      items: [
        DropdownMenuItem(
          value: 'Chroma',
          child: defaultDropdownText('Chroma'),
        ),
        DropdownMenuItem(
          value: 'Luma',
          child: defaultDropdownText('Luma'),
        ),
      ],
      onChanged: (String value) {
        if (value == 'Chroma') {
          settingsService.updateKeyType(KeyType.chroma);
        } else {
          settingsService.updateKeyType(KeyType.luma);
        }
      },
      decoration: InputDecoration(
        labelText: 'Key Type',
        labelStyle: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  Widget settingsPanelFontSelection(SettingsService settingsService) {
    return DropdownButtonFormField(
      value: 'Raleway',
      decoration: InputDecoration(
        labelText: 'Font',
        labelStyle: GoogleFonts.raleway(
          textStyle: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      items: [
        fontSelectionDropdownText('Concert One'),
        fontSelectionDropdownText('Dancing Script'),
        fontSelectionDropdownText('Indie Flower'),
        fontSelectionDropdownText('Lato'),
        fontSelectionDropdownText('Lora'),
        fontSelectionDropdownText('Modak'),
        fontSelectionDropdownText('Monoton'),
        fontSelectionDropdownText('Montserrat'),
        fontSelectionDropdownText('Open Sans'),
        fontSelectionDropdownText('Oswald'),
        fontSelectionDropdownText('Pacifico'),
        fontSelectionDropdownText('Permanent Marker'),
        fontSelectionDropdownText('Press Start 2P'),
        fontSelectionDropdownText('PT Sans'),
        fontSelectionDropdownText('Raleway'),
        fontSelectionDropdownText('Roboto'),
        fontSelectionDropdownText('Source Sans Pro'),
        fontSelectionDropdownText('Special Elite'),
        fontSelectionDropdownText('Underdog'),
        fontSelectionDropdownText('Work Sans'),
      ],
      onChanged: (fontName) {
        settingsService.updateGoogleFontName(fontName);
      },
    );
  }

  Widget fontSizeSelector(SettingsService settingsService) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Font Size',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Slider(
            min: 10,
            max: 900,
            activeColor: Colors.black,
            inactiveColor: Colors.black38,
            value: settingsService.preferences.timerFontSize,
            onChanged: (fontSize) {
              settingsService.updateTimerFontSize(fontSize);
            },
          ),
        ],
      ),
    );
  }

  Widget defaultDropdownText(String text) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(fontSize: 12),
      ),
    );
  }

  DropdownMenuItem fontSelectionDropdownText(String fontName) {
    return DropdownMenuItem(
      value: fontName,
      child: Text(
        fontName,
        style: GoogleFonts.getFont(
          fontName,
          textStyle: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
