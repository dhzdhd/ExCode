import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:excode/src/settings/services/update_service.dart';
import 'package:excode/src/settings/widgets/about_dialog.dart';
import 'package:excode/src/settings/widgets/dropdown_button.dart';
import 'package:excode/src/settings/widgets/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../helpers.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useState(ThemeMode.system);
    final editorTheme = ref.watch(editorThemeStateProvider);
    final globalTheme = ref.watch(themeStateProvider);
    final tabSpaceNotifier = ref.watch(tabSpaceProvider.notifier);
    final fontSizeNotifier = ref.watch(fontSizeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
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
                      child: DropdownButton<Themes>(
                        dropdownColor: globalTheme.primaryColor,
                        focusColor: globalTheme.secondaryColor,
                        isExpanded: true,
                        onChanged: (value) async {
                          await ref
                              .watch(editorThemeStateProvider.notifier)
                              .setTheme(value!.name);
                        },
                        value: getEnumFromString(editorTheme),
                        items: Themes.values
                            .map((val) => DropdownMenuItem(
                                  child: Text(val.name.capitalize()),
                                  value: val,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.font_download),
                    title: const Text('Font size'),
                    trailing: StyledDropdownContainer(
                      child: DropdownButton<int>(
                        dropdownColor: globalTheme.primaryColor,
                        focusColor: globalTheme.secondaryColor,
                        isExpanded: true,
                        value: ref.watch(fontSizeProvider).toInt(),
                        items: List.generate(
                          41,
                          (index) => DropdownMenuItem(
                            child: Text((index + 5).toString()),
                            value: index + 5,
                          ),
                        ),
                        onChanged: (val) {
                          fontSizeNotifier.setFontSize(val!.toDouble());
                        },
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
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return InfoDialogWidget(
                                isLatestVersion:
                                    UpdateService.isLatestVersion(),
                              );
                            });
                      },
                      child: const Text(
                        'Check for updates',
                        style: TextStyle(fontSize: 16),
                      ),
                      style:
                          TextButton.styleFrom(minimumSize: const Size(0, 50)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return const AboutDialogWidget();
                            });
                      },
                      child: const Text(
                        'About and Credits',
                        style: TextStyle(fontSize: 16),
                      ),
                      style:
                          TextButton.styleFrom(minimumSize: const Size(0, 50)),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            const SizedBox(child: Text('Build v0.2.0'))
          ],
        ),
      ),
    );
  }
}
