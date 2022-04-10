import 'package:flutter/material.dart';

class EditorWidget extends StatelessWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      enableInteractiveSelection: true,
      expands: true,
      maxLines: null,
    );
  }
}
