import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:flutter/foundation.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';
import 'src/settings/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux) {
    doWhenWindowReady(() {
      final window = appWindow;
      window.show();
    });
  }

  initDioClient();
  initDatabase();
  await ApiHandler.initRuntimeVersionData();
  await SettingsService.initPrefs();

  runApp(const ProviderScope(child: MyApp()));
}
