import 'package:excode/src/home/widgets/app_bar.dart' show AppBarWidget;
import 'package:excode/src/home/widgets/drawer.dart';
import 'package:excode/src/home/widgets/editor.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: EditorWidget(),
    );
  }
}
