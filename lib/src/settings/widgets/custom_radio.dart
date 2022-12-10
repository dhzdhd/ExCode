import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RadioButtonWidget extends ConsumerWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            // tabSizeState.value = TabEnum.two;
            settingsNotifier.setTabSize(TabEnum.two);
          },
          child: const Text('Two'),
        ),
        ElevatedButton(
          onPressed: () {
            // tabSizeState.value = TabEnum.four;
            settingsNotifier.setTabSize(TabEnum.four);
          },
          child: const Text('Four'),
        ),
      ],
    );
  }
}
