import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obs_countdown_timer/src/services/settings_service.dart';
import 'package:obs_countdown_timer/src/widgets/countdown_widget.dart';
import 'package:obs_countdown_timer/src/models/preferences.dart';
import 'package:provider/provider.dart';

class Screen extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          CountdownWidget(),
          settingsPanel(context),
        ],
      ),
    );
  }

  Widget settingsPanel(BuildContext context) {
    return Consumer<SettingsService>(
      builder: (context, settingsService, child) {
        // If the panel is closed, just throw up an empty container
        if (!settingsService.preferences.panelOpen) {
          return Container();
        }

        return Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(15),
          width: 425,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingsPanelHeader(),
              settingsPanelDescription(),
              settingsPanelKeyType(settingsService),
              settingsPanelFontSelection(settingsService),
              settingsPanelFontSizeSelector(settingsService),
              settingsPanelButtons(settingsService, context),
              reopenPanelMessage(),
            ],
          ),
        );
      },
    );
  }

  Widget settingsPanelHeader() {
    return Container(
      width: 395,
      child: Text(
        'Simple OBS Timer Overlay',
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          textStyle: TextStyle(
            fontSize: 18,
          ),
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
      value: 'Open Sans',
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

  Widget settingsPanelFontSizeSelector(SettingsService settingsService) {
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

  Widget settingsPanelButtons(
      SettingsService settingsService, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        settingsPanelFontColorSelector(settingsService, context),
        settingsPanelSelectEndTime(settingsService, context),
        settingsPanelClose(settingsService),
      ],
    );
  }

  Widget settingsPanelFontColorSelector(
      SettingsService settingsService, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: ElevatedButton(
        child: Text(
          'Select Timer Color',
          style: TextStyle(fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.black87),
        onPressed: () {
          showDialog(
            context: context,
            child: colorPicker(settingsService, context),
          );
        },
      ),
    );
  }

  Widget settingsPanelSelectEndTime(
      SettingsService settingsService, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: ElevatedButton(
        child: Text(
          'Select End Time',
          style: TextStyle(fontSize: 12),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.black87),
        onPressed: () async {
          TimeOfDay selectedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          settingsService.updateEndTime(selectedTime);
        },
      ),
    );
  }

  Widget settingsPanelClose(SettingsService settingsService) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        child: Text(
          'Close Settings',
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () {
          settingsService.closeSettingsPanel();
        },
      ),
    );
  }

  Widget reopenPanelMessage() {
    return Container(
      width: 395,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        'Double-click anywhere inside window to reopen these settings.',
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
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

  Widget colorPicker(SettingsService settingsService, BuildContext context) {
    return AlertDialog(
      title: Text('Select Timer Color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: settingsService.preferences.timerColor,
          onColorChanged: (changedColor) {
            settingsService.updateTimerFontColor(changedColor);
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
