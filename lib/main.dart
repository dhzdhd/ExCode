import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/settings/services/settings_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leak_tracker/leak_tracker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await dotenv.load(fileName: 'dotenv');
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
  } else if (!kIsWeb) {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const ProviderScope(child: MyApp())),
    );
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }

  if ([TargetPlatform.windows, TargetPlatform.linux, TargetPlatform.macOS]
      .contains(defaultTargetPlatform)) {
    doWhenWindowReady(() {
      final window = appWindow;
      const initialSize = Size(900, 600);
      appWindow.size = initialSize;
      window.alignment = Alignment.center;
      window.show();
    });
  }
}
