import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LangVersionDialogWidget extends ConsumerWidget {
  const LangVersionDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: const Text('Language versions'),
      titlePadding: const EdgeInsets.all(24),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
      children: ApiHandler.langVersionMap.entries
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: ref.watch(themeStateProvider).primaryColor,
              ),
              child: Column(
                children: [
                  Text(e.key),
                  Text(e.value),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
