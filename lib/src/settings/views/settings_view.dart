import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class SettingsView extends HookWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final theme = useState(ThemeMode.system);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Theme'),
              trailing: Consumer(builder: (_, WidgetRef ref, __) {
                return DropdownButton<ThemeMode>(
                  onChanged: ((val) {
                    theme.value = val!;
                    ref
                        .watch(themeStateProvider.notifier)
                        .changeTheme(theme.value);
                  }),
                  value: theme.value,
                  items: ThemeMode.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name.capitalize()),
                            value: e,
                          ))
                      .toList(),
                );
              }),
            ),
            ListTile(
              leading: const Icon(Icons.font_download),
              title: const Text('Editor font'),
              trailing: DropdownButton<String>(
                onChanged: (value) => value,
                value: '',
                items: [DropdownMenuItem(child: Text(''), value: '')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
