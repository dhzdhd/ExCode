import 'package:clipboard/clipboard.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/widgets/input_dialog.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/services/paste.dart';
import 'package:excode/src/settings/views/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class AppBarWidget extends HookConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorLanguage = ref.watch(editorLanguageStateProvider);
    final isSaveOnRun =
        ref.watch(settingsProvider.select((value) => value.isSaveOnRun));
    final isLocked =
        ref.watch(settingsProvider.select((value) => value.isLocked));
    final activeFile = ref.watch(activeFileProvider);

    return AppBar(
      automaticallyImplyLeading: !kIsWeb,
      title: activeFile.match(
        () => DropdownSearch<Language>(
          selectedItem: getLangFromName(editorLanguage).lang,
          items: Language.values,
          itemAsString: (Language? e) => e.toString().substring(9).capitalize(),
          onChanged: (val) {
            final String lang = getLangFromEnum(val!).name;

            ref.read(editorLanguageStateProvider.notifier).setLanguage(lang);
            ref
                .read(editorContentStateProvider.notifier)
                .setContent(const None(), lang);
          },
        ),
        (t) => Text(t.language.capitalize()),
      ),
      actions: [
        SizedBox(
          width: 40,
          child: Tooltip(
            message: 'Run code',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              child: ref.watch(outputIsLoadingProvider)
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              onPressed: () async {
                await ref.read(outputContentStateProvider.notifier).setOutput(
                      getLangFromName(editorLanguage).lang,
                      ref.watch(editorContentStateProvider),
                    );
                ref.read(outputIsVisibleStateProvider.notifier).showOutput();
                if (isSaveOnRun) {
                  await ref
                      .watch(editorContentStateProvider.notifier)
                      .saveContent(
                        ref.read(editorLanguageStateProvider),
                        ref.read(editorContentStateProvider),
                      );
                }
              },
              onLongPress: () async {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return const InputDialogWidget();
                  }),
                );
              },
            ),
          ),
        ),
        IconButton(
          tooltip: 'Settings',
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
                  if (!isLocked) {
                    ref
                        .watch(editorContentStateProvider.notifier)
                        .setContent(const Some(''));
                  }
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
                  if (context.mounted) {
                    context.showSuccessSnackBar(
                        content: 'Saved to local storage!',
                        action: const None());
                  }
                },
              ),
              PopupMenuItem(
                child: const Text('Pastebin'),
                onTap: () async {
                  final url = await CustomPasteBin.post(
                    lang: ref.read(editorLanguageStateProvider),
                    content: ref.read(editorContentStateProvider),
                  );
                  url.match(
                    (l) => context.showErrorSnackBar(l),
                    (r) => context.showSuccessSnackBar(
                      content:
                          'Uploaded to pastebin. The url expires after a few days!',
                      action: Some(
                        SnackBarAction(
                          label: 'Copy',
                          onPressed: () =>
                              FlutterClipboard.copy(r).then((value) {
                            context.showSuccessSnackBar(
                              content: 'Copied pastebin url to clipboard',
                              action: const None(),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ];
          }));
        }),
      ],
    );
  }
}
