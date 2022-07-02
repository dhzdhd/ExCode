import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:excode/src/home/widgets/app_bar.dart' show AppBarWidget;
import 'package:excode/src/home/widgets/drawer.dart';
import 'package:excode/src/home/widgets/editor.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);

    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: EditorWidget(),
    );
  }
}
