import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/widgets/app_bar.dart' show AppBarWidget;
import 'package:excode/src/home/widgets/drawer.dart';
import 'package:excode/src/home/widgets/editor.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ! Remove appbar for large screen sizes and add file drawer to the left.

class HomeView extends ConsumerStatefulWidget {
  static const routeName = '/';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AfterLayoutMixin<HomeView> {
  late final bool firstLaunch;

  @override
  void initState() {
    super.initState();

    firstLaunch = box.get('firstLaunch', defaultValue: true);
    box.put('firstLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = ref.watch(themeStateProvider);
    final isFloatingRunVisible = ref
        .watch(settingsProvider.select((value) => value.isFloatingRunVisible));
    final isSaveOnRun =
        ref.watch(settingsProvider.select((value) => value.isSaveOnRun));

    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: kIsWeb ? null : const DrawerWidget(),
      body: const EditorWidget(),
      floatingActionButton: LayoutBuilder(builder: (context, constraints) {
        return Visibility(
          visible: isFloatingRunVisible && !(constraints.maxWidth > 700),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ref.watch(outputIsVisibleStateProvider)
                ? null
                : FloatingActionButton(
                    onPressed: () async {
                      await ref
                          .watch(outputContentStateProvider.notifier)
                          .setOutput(
                            getLangFromName(
                              ref.watch(editorLanguageStateProvider),
                            ).lang,
                            ref.watch(editorContentStateProvider),
                          );
                      ref
                          .watch(outputIsVisibleStateProvider.notifier)
                          .showOutput();
                      if (isSaveOnRun) {
                        await ref
                            .watch(editorContentStateProvider.notifier)
                            .saveContent(
                              ref.read(editorLanguageStateProvider),
                              ref.read(editorContentStateProvider),
                            );
                      }
                    },
                    backgroundColor: globalTheme.accentColor,
                    foregroundColor: globalTheme.primaryColor,
                    child: ref.watch(outputIsLoadingProvider)
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: globalTheme.primaryColor,
                            ),
                          )
                        : const Icon(Icons.play_arrow),
                  ),
          ),
        );
      }),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    showSentryDialog();
  }

  void showSentryDialog() {
    // ! Change condition
    if (firstLaunch && !getSentryFromStorage()) {
      Future.delayed(
        Duration.zero,
        () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Sentry Error Tracker'),
              contentPadding: const EdgeInsets.all(24),
              content: const Text(
                '''This app uses the open source platform - Sentry to track errors in the app.
This feature is completely optional and is disabled by default.
The platform tracks the device information and the error that occured in the app.
This helps the developer to quickly fix any bugs encountered.''',
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left: 15, right: 15)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                OutlinedButton(
                  child: const Text(
                    'Enable Sentry',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    ref.read(settingsProvider.notifier).setSentry(true);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
      );
    }
  }
}
