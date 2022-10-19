import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/cloud/services/supabase.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/settings/services/update_service.dart';
import 'package:flutter/foundation.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';
import 'src/settings/services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if ([TargetPlatform.windows, TargetPlatform.linux, TargetPlatform.macOS]
      .contains(defaultTargetPlatform)) {
    doWhenWindowReady(() {
      final window = appWindow;
      window.show();
    });
  }

  initDioClient();
  SupabaseUtils.initCloudStorage();
  await initDatabase();
  await initPackageInfo();
  await ApiHandler.initRuntimeVersionData();
  await UpdateService.initVersion();
  await SettingsService.initPrefs();

  runApp(const ProviderScope(child: MyApp()));
}
