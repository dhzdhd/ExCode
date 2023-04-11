import 'dart:async';
import 'dart:math';

import 'package:code_text_field/code_text_field.dart' show CodeController;
import 'package:excode/src/home/widgets/text_selection_controls.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class CodeFieldWidget extends StatefulWidget {
  final bool wrap;
  final CodeController controller;
  final TextStyle textStyle;
  final FocusNode? focusNode;
  final void Function(String) onChanged;
  final double initialListViewWidth;
  final bool enabled;

  const CodeFieldWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.textStyle,
    required this.enabled,
    this.initialListViewWidth = 20.0,
    this.wrap = false,
    this.focusNode,
  }) : super(key: key);

  @override
  CodeFieldWidgetState createState() => CodeFieldWidgetState();
}

class CodeFieldWidgetState extends State<CodeFieldWidget> {
  late final LinkedScrollControllerGroup _scrollControllers;
  late final ScrollController _numberController;
  late final ScrollController _fieldController;
  late double _listViewWidth;

  StreamSubscription<bool>? _keyboardVisibilitySubscription;
  FocusNode? _focusNode;
  late int _lineCount;
  String longestLine = '';
  int _selectedLine = 0;

  @override
  void initState() {
    super.initState();
    _scrollControllers = LinkedScrollControllerGroup();
    _numberController = _scrollControllers.addAndGet();
    _fieldController = _scrollControllers.addAndGet();

    widget.controller.addListener(_updateLineNumber);

    _listViewWidth = widget.initialListViewWidth;

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.attach(context, onKey: _onKey);

    _lineCount = '\n'.allMatches(widget.controller.text).length + 1;
  }

  @override
  void didUpdateWidget(CodeFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _lineCount = '\n'.allMatches(widget.controller.text).length + 1;
    _setNumber(widget.controller.text);

    widget.controller.addListener(_updateLineNumber);
    oldWidget.controller.removeListener(_updateLineNumber);
  }

  @override
  void dispose() {
    _numberController.dispose();
    _fieldController.dispose();
    _keyboardVisibilitySubscription?.cancel();

    widget.controller.removeListener(_updateLineNumber);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Default color scheme
    const rootKey = 'root';
    final defaultBg = Colors.grey.shade900;
    final defaultText = Colors.grey.shade200;

    final theme = widget.controller.theme;
    Color? backgroundCol = theme?[rootKey]?.backgroundColor ?? defaultBg;

    TextStyle textStyle = widget.textStyle;
    textStyle = textStyle.copyWith(
      color: textStyle.color ?? theme?[rootKey]?.color ?? defaultText,
    );

    final numberCol = SizedBox(
      width: _listViewWidth,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 3),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            controller: _numberController,
            children: List.generate(_lineCount, (index) => index + 1)
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 0.5, bottom: 0.5),
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        fontSize: widget.textStyle.fontSize,
                        color: _getLineNumberColor(
                            e == _selectedLine, theme, rootKey),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );

    final codeField = TextField(
      selectionControls: CustomTextSelectionControls(),
      enabled: widget.enabled,
      focusNode: _focusNode,
      style: textStyle,
      controller: widget.controller,
      expands: true,
      maxLines: null,
      scrollController: _fieldController,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      cursorColor: theme?[rootKey]?.color ?? defaultText,
      autocorrect: false,
      enableSuggestions: false,
      onChanged: (value) {
        _setNumber(value);
        widget.onChanged(value);
      },
    );

    final codeCol = Theme(
      data: Theme.of(context),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Control horizontal scrolling
          return widget.wrap
              ? codeField
              : _wrapInScrollView(codeField, textStyle, constraints.maxWidth);
        },
      ),
    );
    return Container(
      color: backgroundCol,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          numberCol,
          const VerticalDivider(),
          Expanded(child: codeCol),
        ],
      ),
    );
  }

  void _setNumber(String text) {
    setState(() {
      _lineCount = '\n'.allMatches(text).length + 1;
      _listViewWidth = 5 + 12.0 * _getDigits(_lineCount);
    });
  }

  int _getDigits(int num) {
    var count = 0;
    while (num != 0) {
      num = (num / 10).floor();
      count++;
    }
    return count;
  }

  Color? _getLineNumberColor(
      bool selected, Map<String, TextStyle>? theme, String? rootKey) {
    if (theme != null && rootKey != null) {
      return selected
          ? theme[rootKey]!.color
          : theme[rootKey]!.color?.withAlpha(128);
    } else {
      return selected ? Colors.white : Colors.grey;
    }
  }

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    return widget.controller.onKey(event);
  }

  void _updateLineNumber() {
    final offset = widget.controller.selection.base.offset;
    setState(() {
      _selectedLine = '\n'
              .allMatches(widget.controller.text.substring(
                0,
                offset,
              ))
              .length +
          1;
    });
  }

  // Wrap the field in a horizontal ScrollView
  Widget _wrapInScrollView(
      Widget codeField, TextStyle textStyle, double minWidth) {
    const leftPad = 0.0;
    final intrinsic = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0.0,
              minWidth: max(minWidth - leftPad, 0.0),
            ),
            child: Padding(
              child: Text(longestLine, style: textStyle),
              padding: const EdgeInsets.only(right: 16.0),
            ),
          ),
          Expanded(child: codeField)
        ],
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: leftPad,
      ),
      scrollDirection: Axis.horizontal,
      child: intrinsic,
    );
  }
}
