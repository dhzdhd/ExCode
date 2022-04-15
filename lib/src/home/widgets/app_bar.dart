import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class AppBarWidget extends HookConsumerWidget with PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorLang = ref.watch(editorStateProvider).languageId;
    final lang = useState(Languages.python);

    return AppBar(
      title: DropdownButton<Languages>(
        value: lang.value,
        items: Languages.values
            .map((e) => DropdownMenuItem<Languages>(
                  child: Text(e.name.capitalize()),
                  value: e,
                ))
            .toList(),
        onChanged: (val) {
          lang.value = val!;
          ref
              .watch(editorStateProvider.notifier)
              .setLanguage(getThemeLangFromEnum(val));
        },
      ),
      automaticallyImplyLeading: false,
      actions: [
        Consumer(builder: (_, ref, __) {
          return IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () async {
              final res = await ApiHandler.executeCode(
                  lang.value, ref.watch(editorContentStateProvider));
              ref.watch(outputStateProvider.notifier).setOutput(res);
            },
          );
        }),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.restorablePushNamed(context, SettingsView.routeName);
          },
        ),
      ],
    );
  }
}
