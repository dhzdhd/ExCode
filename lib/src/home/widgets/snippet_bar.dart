import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/widgets/snippet_dialog.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnippetBarWidget extends ConsumerWidget {
  final TextEditingController controller;

  const SnippetBarWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snippetList = ref.watch(snippetBarStateProvider);
    final isLocked =
        ref.watch(settingsProvider.select((value) => value.isLocked));
    final tabSize =
        ref.watch(settingsProvider.select((value) => value.tabSize));

    return SizedBox(
      height: 34,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TextButton(
                  onPressed: () {
                    if (!isLocked) {
                      final spaces = tabSize.space;
                      ref
                          .watch(cursorSelectionStateProvider.notifier)
                          .setCursorSelection(
                            controller.selection.baseOffset + spaces.length,
                          );
                      ref.watch(editorContentStateProvider.notifier).addContent(
                            spaces,
                            controller.selection.base,
                          );
                    }
                  },
                  child: const Text('TAB'),
                ),
                ...snippetList.map(
                  (e) => TextButton(
                    onPressed: () {
                      if (!isLocked) {
                        ref
                            .watch(cursorSelectionStateProvider.notifier)
                            .setCursorSelection(
                              controller.selection.baseOffset + e.length,
                            );
                        ref
                            .watch(editorContentStateProvider.notifier)
                            .addContent(e.value, controller.selection.base);
                      }
                    },
                    child: Text(e.name),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const BottomBarDialogWidget(),
              );
            },
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              foregroundColor: ref.watch(themeStateProvider).accentColor,
              shape: const BeveledRectangleBorder(),
            ),
          )
        ],
      ),
    );
  }
}
