import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ! deprecate

class BottomBarWidget extends ConsumerWidget {
  final FocusNode focusNode;
  final TextSelection selection;

  const BottomBarWidget(
      {Key? key, required this.focusNode, required this.selection})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent(ref.watch(tabSpaceProvider).space, selection.base),
          child: const Text('TAB'),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('()', selection.base),
          child: const Text('( )'),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('{}', selection.base),
          child: const Text('{ }'),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('[]', selection.base),
          child: const Text('[ ]'),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('""', selection.base),
          child: const Text('"'),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('\'\'', selection.base),
          child: const Text('\''),
        ),
        TextButton(
          onPressed: () => ref
              .watch(editorContentStateProvider.notifier)
              .addContent('``', selection.base),
          child: const Text('`'),
        ),
        TextButton(
          onPressed: () {
            ref
                .watch(editorContentStateProvider.notifier)
                .addContent('<>', selection.base);
            focusNode.requestFocus();
          },
          child: const Text('< >'),
        )
      ],
    );
  }
}
