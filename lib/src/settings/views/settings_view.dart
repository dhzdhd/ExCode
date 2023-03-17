import 'package:excode/src/factory.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:excode/src/settings/services/update_service.dart';
import 'package:excode/src/settings/widgets/about_dialog.dart';
import 'package:excode/src/settings/widgets/auth_dropdown.dart';
import 'package:excode/src/settings/widgets/dropdown_button.dart';
import 'package:excode/src/settings/widgets/font_size_button.dart';
import 'package:excode/src/settings/widgets/update_dialog.dart';
import 'package:excode/src/settings/widgets/lang_version_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
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
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final tabSize =
        ref.watch(settingsProvider.select((value) => value.tabSize));
    final isTabBarVisible =
        ref.watch(settingsProvider.select((value) => value.isTabBarVisible));
    final isWordWrapped =
        ref.watch(settingsProvider.select((value) => value.isWordWrapped));
    final isSaveOnRun =
        ref.watch(settingsProvider.select((value) => value.isSaveOnRun));
    final isLocked =
        ref.watch(settingsProvider.select((value) => value.isLocked));
    final isFloatingRunVisible = ref
        .watch(settingsProvider.select((value) => value.isFloatingRunVisible));
    final isSaveToCloud =
        ref.watch(settingsProvider.select((value) => value.isSaveToCloud));
    final isSentryEnabled =
        ref.watch(settingsProvider.select((value) => value.isSentryEnabled));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: AuthDropDownWidget(),
          ),
        ],
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
                  const ListTile(
                    leading: Icon(Icons.font_download),
                    title: Text('Font size'),
                    trailing: FontSizeButtonWidget(),
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
                        value: tabSize,
                        onChanged: (val) async {
                          await settingsNotifier.setTabSize(val!);
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.tab),
                    title: const Text('Show tabs'),
                    trailing: Switch(
                        value: isTabBarVisible,
                        onChanged: (val) async {
                          await settingsNotifier.setTabBarVisibility();
                        }),
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_format),
                    title: const Text('Word wrap'),
                    trailing: Switch(
                        value: isWordWrapped,
                        onChanged: (val) async {
                          await settingsNotifier.setWordWrapped();
                        }),
                  ),
                  ListTile(
                    leading: const Icon(Icons.save),
                    title: const Text('Save on run'),
                    trailing: Switch(
                        value: isSaveOnRun,
                        onChanged: (val) async {
                          await settingsNotifier.setSaveOnRun();
                        }),
                  ),
                  Visibility(
                    visible: supabase.auth.currentUser != null,
                    child: ListTile(
                      leading: const Icon(Icons.cloud),
                      title: const Text('Save to cloud'),
                      trailing: Switch(
                        value: isSaveToCloud,
                        onChanged: (val) async {
                          await settingsNotifier.setSaveToCloud();
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Lock editor'),
                    trailing: Switch(
                        value: isLocked,
                        onChanged: (val) {
                          settingsNotifier.setLocked();
                          context.showSuccessSnackBar(
                            content:
                                !isLocked ? 'Locked editor' : 'Unlocked editor',
                            action: const None(),
                          );
                        }),
                  ),
                  ListTile(
                    leading: const Icon(Icons.play_arrow),
                    title: const Text('Show floating run'),
                    trailing: Switch(
                        value: isFloatingRunVisible,
                        onChanged: (val) async {
                          await settingsNotifier.setFloatingRunVisibility();
                        }),
                  ),
                  Visibility(
                    visible: !kIsWeb,
                    child: ListTile(
                      leading: const Icon(Icons.monitor_heart_outlined),
                      title: const Text('Enable Sentry'),
                      trailing: Switch(
                          value: isSentryEnabled,
                          onChanged: (val) async {
                            await settingsNotifier.setSentry();
                          }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return const LangVersionDialogWidget();
                            });
                      },
                      child: const Text(
                        'Language versions',
                        style: TextStyle(fontSize: 16),
                      ),
                      style:
                          TextButton.styleFrom(minimumSize: const Size(0, 50)),
                    ),
                  ),
                  if (defaultTargetPlatform == TargetPlatform.android)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: ElevatedButton(
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
                        style: TextButton.styleFrom(
                            minimumSize: const Size(0, 50)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return const AboutDialogWidget();
                          },
                        );
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
            if (defaultTargetPlatform != TargetPlatform.windows)
              SizedBox(
                child: Text(
                  kIsWeb ? 'Build latest' : 'Build v${packageInfo.version}',
                ),
              )
          ],
        ),
      ),
    );
  }
}
