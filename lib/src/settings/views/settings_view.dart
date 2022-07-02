import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:excode/src/settings/widgets/dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useState(ThemeMode.system);
    final editorTheme = ref.watch(editorThemeStateProvider)['theme'];
    final globalTheme = ref.watch(themeStateProvider);
    final tabSpaceNotifier = ref.watch(tabSpaceProvider.notifier);

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
              trailing: StyledDropdownContainer(
                child: DropdownButton<ThemeMode>(
                  dropdownColor: globalTheme.primaryColor,
                  focusColor: globalTheme.secondaryColor,
                  isExpanded: true,
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
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text('Editor theme'),
              trailing: StyledDropdownContainer(
                child: DropdownButton<Map<String, TextStyle>>(
                  dropdownColor: globalTheme.primaryColor,
                  focusColor: globalTheme.secondaryColor,
                  isExpanded: true,
                  onChanged: (value) => ref
                      .watch(editorThemeStateProvider.notifier)
                      .setTheme(value!),
                  value: editorTheme,
                  items: Themes.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name.capitalize()),
                            value: getThemeFromEnum(e),
                          ))
                      .toList(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.space_bar),
              title: const Text('Tab space'),
              trailing: StyledDropdownContainer(
                child: DropdownButton<TabEnum>(
                  dropdownColor: globalTheme.primaryColor,
                  focusColor: globalTheme.secondaryColor,
                  isExpanded: true,
                  items: TabEnum.values
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.name.capitalize()),
                          value: e,
                        ),
                      )
                      .toList(),
                  value: ref.watch(tabSpaceProvider),
                  onChanged: (val) async {
                    await tabSpaceNotifier.setTabSpace(val!);
                  },
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.text_format),
              title: const Text('Word wrap'),
              trailing: Switch(
                  value: ref.watch(settingsProvider),
                  onChanged: (val) {
                    ref.watch(settingsProvider.notifier).setWordWrapped();
                  }),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('Save on run'),
              trailing: Switch(
                  value: ref.watch(saveOnRunProvider),
                  onChanged: (val) {
                    ref.watch(saveOnRunProvider.notifier).setSaveOnRun();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
