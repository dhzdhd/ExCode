import 'package:dropdown_search/dropdown_search.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:excode/src/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class AppBarWidget extends HookConsumerWidget with PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorLanguage = ref.watch(editorLanguageStateProvider);
    final globalTheme = ref.watch(themeStateProvider);

    return AppBar(
      title: DropdownSearch<Languages>(
        mode: Mode.MENU,
        popupBackgroundColor: globalTheme.primaryColor,
        showSearchBox: true,
        selectedItem: langMap[editorLanguage]!.lang,
        items: Languages.values,
        itemAsString: (Languages? e) => e.toString().substring(10).capitalize(),
        onChanged: (val) {
          String lang = ApiHandler.getNameFromLang(val!);
          ref.watch(editorLanguageStateProvider.notifier).setLanguage(lang);
          ref.watch(editorContentStateProvider.notifier).setContent(
              box.get('${lang}code') ??
                  langMap[lang]!.baseCode); // ! Move to provider
        },
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () async {
            await ref.watch(outputStateProvider.notifier).setOutput(
                  langMap[editorLanguage]!.lang,
                  ref.watch(editorContentStateProvider),
                );
            ref.watch(outputIsVisibleStateProvider.notifier).showOutput();
            if (ref.watch(saveOnRunProvider)) {
              await ref.watch(editorContentStateProvider.notifier).saveContent(
                    ref.read(editorLanguageStateProvider),
                    ref.read(editorContentStateProvider),
                  );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
        Consumer(builder: (_, ref, __) {
          return PopupMenuButton<String>(itemBuilder: ((context) {
            return [
              PopupMenuItem(
                child: const Text('Clear'),
                onTap: () {
                  ref.watch(editorContentStateProvider.notifier).setContent('');
                },
              ),
              PopupMenuItem(
                child: const Text('Save'),
                onTap: () async {
                  await ref
                      .watch(editorContentStateProvider.notifier)
                      .saveContent(
                        ref.read(editorLanguageStateProvider),
                        ref.read(editorContentStateProvider),
                      );
                },
              )
            ];
          }));
        }),
      ],
    );
  }
}
