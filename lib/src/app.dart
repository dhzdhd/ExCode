import 'dart:async';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/cloud/views/auth_view.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home/views/home_view.dart';
import 'settings/views/settings_view.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyApp();
}

class _MyApp extends ConsumerState<MyApp> {
  late final StreamSubscription _authSub;

  @override
  void initState() {
    super.initState();
    _authSub = supabase.auth.onAuthStateChange.listen((data) {
      ref.read(authProvider.notifier).setUser(data.session?.user);
    });
    initPackageInfo();
  }

  @override
  void dispose() {
    _authSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExCode',
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: lightTheme.theme,
      themeMode:
          ref.watch(themeStateProvider).theme.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
      darkTheme: darkTheme.theme,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            return StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                if (snapshot.data != ConnectivityResult.none) {
                  return switch (routeSettings.name) {
                    SettingsView.routeName =>
                      const TitleBarWidget(child: SettingsView()),
                    HomeView.routeName =>
                      const TitleBarWidget(child: HomeView()),
                    AuthView.routeName =>
                      const TitleBarWidget(child: AuthView()),
                    _ => const TitleBarWidget(child: HomeView())
                  };
                } else {
                  return const TitleBarWidget(
                    child: Scaffold(
                      body: Center(
                        child: Text(
                          'You are not connected to the internet.\nPlease try again later.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

class TitleBarWidget extends ConsumerWidget {
  final Widget child;

  const TitleBarWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);

    return Column(
      children: [
        if ([TargetPlatform.windows, TargetPlatform.linux, TargetPlatform.macOS]
            .contains(defaultTargetPlatform))
          WindowTitleBarBox(
            child: Container(
              color: globalTheme.secondaryColor,
              child: Row(children: [
                Expanded(
                  child: MoveWindow(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 12,
                              color: globalTheme.theme.brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            child: const Text(
                              'ExCode',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                WindowButtons(theme: globalTheme),
              ]),
            ),
          ),
        Expanded(child: child),
      ],
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key, required this.theme});

  final ThemeDataModel theme;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = theme.theme.brightness == Brightness.light;

    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: isLightTheme ? Colors.black : Colors.white,
            iconMouseDown: isLightTheme ? Colors.black : Colors.white,
            iconMouseOver: isLightTheme ? Colors.black : Colors.white,
            mouseOver: isLightTheme
                ? Colors.black.withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
            mouseDown: isLightTheme
                ? Colors.black.withOpacity(0.2)
                : Colors.white.withOpacity(0.2),
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: isLightTheme ? Colors.black : Colors.white,
            iconMouseDown: isLightTheme ? Colors.black : Colors.white,
            iconMouseOver: isLightTheme ? Colors.black : Colors.white,
            mouseOver: isLightTheme
                ? Colors.black.withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
            mouseDown: isLightTheme
                ? Colors.black.withOpacity(0.2)
                : Colors.white.withOpacity(0.2),
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            iconNormal: isLightTheme ? Colors.black : Colors.white,
            mouseOver: Colors.redAccent,
            mouseDown: Colors.red,
          ),
        ),
      ],
    );
  }
}
