import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/providers/settings_controller.dart';
import 'src/settings/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(const MyApp());
}
