import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/settings/services/settings_service.dart';
import 'package:flutter/foundation.dart';
import 'package:leak_tracker/leak_tracker.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';

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
  await initCloudStorage();
  await initFileStorage();
  await initDatabase();
  await ApiHandler.initRuntimeVersionData();
  await SettingsService.initPrefs();

  if (defaultTargetPlatform == TargetPlatform.android) {
    await initDownloader();
  }

  if (kDebugMode) {
    // ! Update package to enable links https://pub.dev/packages/leak_tracker
    enableLeakTracking();
    MemoryAllocations.instance.addListener(
      (ObjectEvent event) => dispatchObjectEvent(event.toMap()),
    );
    runApp(const ProviderScope(child: MyApp()));
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }
}
