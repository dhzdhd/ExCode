import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RadioButtonWidget extends ConsumerWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState<TabEnum>(ref.watch(tabSpaceProvider));

    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            state.value = TabEnum.two;
            ref.watch(tabSpaceProvider.notifier).setTabSpace(TabEnum.two);
          },
          child: const Text('Two'),
        ),
        ElevatedButton(
          onPressed: () {
            state.value = TabEnum.four;
            ref.watch(tabSpaceProvider.notifier).setTabSpace(TabEnum.four);
          },
          child: const Text('Four'),
        ),
      ],
    );
  }
}
