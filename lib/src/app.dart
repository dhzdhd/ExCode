import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home/views/home_view.dart';
import 'settings/views/settings_view.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return const TitleBarWidget(child: SettingsView());
              case HomeView.routeName:
                return const TitleBarWidget(child: HomeView());
              default:
                return const TitleBarWidget(child: HomeView());
            }
          },
        );
      },
    );
  }
}

class TitleBarWidget extends ConsumerWidget {
  final Widget child;

  const TitleBarWidget({Key? key, required this.child}) : super(key: key);
  static const routeName = '/';

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
  const WindowButtons({Key? key, required this.theme}) : super(key: key);

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
