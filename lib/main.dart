import 'package:excode/src/home/services/api.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';
import 'src/settings/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDioClient();
  initDatabase();
  await ApiHandler.initRuntimeVersionData();
  await SettingsService.initPrefs();

  runApp(const ProviderScope(child: MyApp()));
}
