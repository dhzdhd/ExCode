import 'package:excode/src/home/widgets/app_bar.dart' show AppBarWidget;
import 'package:excode/src/home/widgets/drawer.dart';
import 'package:excode/src/home/widgets/editor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: EditorWidget(),
    );
  }
}
