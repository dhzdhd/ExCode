import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  late final CodeController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        CodeController(language: allLanguages['python'], theme: nordTheme);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CodeField(
          controller: _controller,
          expands: true,
        ),
        OutputWidget(),
      ],
    );
  }
}
