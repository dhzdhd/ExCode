import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:flutter/foundation.dart';
// import 'package:leak_tracker/leak_tracker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'src/factory.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initDioClient();
  await initCloudStorage();
  await initFileStorage();
  await initDatabase();
  await ApiHandler.initRuntimeVersionData();

  if (defaultTargetPlatform == TargetPlatform.android) {
    await initDownloader();
  }

  if (kDebugMode) {
    runApp(const ProviderScope(child: MyApp()));
  } else if (getSentryFromStorage()) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://62b5987538494d3880e80002e190ac98@o4504764245344256.ingest.sentry.io/4504764250521600';
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
