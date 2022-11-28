import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/widgets/app_bar.dart' show AppBarWidget;
import 'package:excode/src/home/widgets/drawer.dart';
import 'package:excode/src/home/widgets/editor.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  static const routeName = '/';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);

    return Scaffold(
      appBar: const AppBarWidget(),
      drawer: const DrawerWidget(),
      body: const EditorWidget(),
      floatingActionButton: LayoutBuilder(builder: (context, constraints) {
        return Visibility(
          visible: ref.watch(floatingRunVisibilityProvider) &&
              !(constraints.maxWidth > 700),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ref.watch(outputIsVisibleStateProvider)
                ? null
                : FloatingActionButton(
                    onPressed: () async {
                      await ref
                          .watch(outputContentStateProvider.notifier)
                          .setOutput(
                            langMap[ref.watch(editorLanguageStateProvider)]!
                                .lang,
                            ref.watch(editorContentStateProvider),
                          );
                      ref
                          .watch(outputIsVisibleStateProvider.notifier)
                          .showOutput();
                      if (ref.watch(saveOnRunProvider)) {
                        await ref
                            .watch(editorContentStateProvider.notifier)
                            .saveContent(
                              ref.read(editorLanguageStateProvider),
                              ref.read(editorContentStateProvider),
                            );
                      }
                    },
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
                    backgroundColor: globalTheme.accentColor,
                    foregroundColor: globalTheme.primaryColor,
                  ),
          ),
        );
      }),
    );
  }
}
