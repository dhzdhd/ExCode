import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/widgets/bottom_bar_dialog.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomBarWidget extends ConsumerWidget {
  final TextEditingController controller;

  const BottomBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonList = ref.watch(bottomBarButtonsStateProvider);

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
                    if (!ref.watch(lockProvider)) {
                      final spaces = ref.watch(tabSpaceProvider).space;
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
                ...buttonList.map(
                  (e) => TextButton(
                    onPressed: () {
                      if (!ref.watch(lockProvider)) {
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