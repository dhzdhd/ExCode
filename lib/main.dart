import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/blocs/settings_controller.dart';
import 'src/settings/services/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp());
}
