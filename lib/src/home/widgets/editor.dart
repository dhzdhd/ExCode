import 'package:flutter/material.dart';

class EditorWidget extends StatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  State<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends State<EditorWidget> {
  var _lineCount = 2;
  var _selectedLine = 1;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
        child: SizedBox(
          width: 25,
          child: ListView(
            children: [
              for (int i = 1; i < _lineCount + 1; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    '$i',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 14,
                      color: i == _selectedLine ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      const VerticalDivider(),
      Expanded(
        child: TextField(
          decoration: const InputDecoration(border: InputBorder.none),
          cursorColor: Colors.white,
          controller: _controller,
          enableInteractiveSelection: true,
          expands: true,
          maxLines: null,
          onChanged: ((text) {
            setState(() {
              newLineMatches(text) => '\n'.allMatches(text);
              _lineCount = newLineMatches(text).length + 1;
              _selectedLine = newLineMatches(text.substring(
                    0,
                    _controller.selection.extentOffset,
                  )).length +
                  1;
            });
          }),
          style: const TextStyle(fontFamily: 'FiraCode'),
        ),
      )
    ]);
  }
}
