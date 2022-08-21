import 'dart:async';
import 'dart:math';

import 'package:code_text_field/code_text_field.dart' show CodeController;
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class CodeFieldWidget extends StatefulWidget {
  final bool wrap;
  final CodeController controller;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final void Function(String) onChanged;
  final double initialListViewWidth;

  const CodeFieldWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.initialListViewWidth = 15.0,
    this.wrap = false,
    this.textStyle,
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
  var _lineCount = 1;
  String longestLine = '';

  @override
  void initState() {
    super.initState();
    _scrollControllers = LinkedScrollControllerGroup();
    _numberController = _scrollControllers.addAndGet();
    _fieldController = _scrollControllers.addAndGet();
    _listViewWidth = widget.initialListViewWidth;
    // widget.controller.addListener(_onTextChanged);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.attach(context, onKey: _onKey);
  }

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    return widget.controller.onKey(event);
  }

  @override
  void dispose() {
    // widget.controller.removeListener(_onTextChanged);
    _numberController.dispose();
    _fieldController.dispose();
    _keyboardVisibilitySubscription?.cancel();
    super.dispose();
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

  int _getDigits(int num) {
    var count = 0;
    while (num != 0) {
      num = (num / 10).floor();
      count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    void setNumber(String text) {
      setState(() {
        _lineCount = '\n'.allMatches(text).length + 1;
        _listViewWidth = 5 + 10.0 * _getDigits(_lineCount);
        // _selectedLine = '\n'
        //         .allMatches(text.substring(
        //           0,
        //           _textController.selection.base.offset,
        //         ))
        //         .length +
        //     1;
        // print(_selectedLine);
      });
    }

    // Default color scheme
    const rootKey = 'root';
    final defaultBg = Colors.grey.shade900;
    final defaultText = Colors.grey.shade200;

    final theme = widget.controller.theme;
    Color? backgroundCol = theme?[rootKey]?.backgroundColor ?? defaultBg;

    TextStyle textStyle = widget.textStyle ?? const TextStyle();
    textStyle = textStyle.copyWith(
      color: textStyle.color ?? theme?[rootKey]?.color ?? defaultText,
      fontSize: textStyle.fontSize ?? 16.0,
    );
    TextStyle numberTextStyle = const TextStyle();
    final numberColor =
        (theme?[rootKey]?.color ?? defaultText).withOpacity(0.7);
    // Copy important attributes
    numberTextStyle = numberTextStyle.copyWith(
      color: numberTextStyle.color ?? numberColor,
      fontSize: textStyle.fontSize,
      fontFamily: textStyle.fontFamily,
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
                  (e) => Text(
                    e.toString(),
                    style: TextStyle(
                      fontSize: widget.textStyle?.fontSize,
                      color: Colors.grey,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );

    final codeField = TextField(
      focusNode: _focusNode,
      // scrollPadding: widget.padding,
      style: textStyle,
      controller: widget.controller,
      expands: true,
      maxLines: null,
      minLines: null,
      scrollController: _fieldController,
      decoration: const InputDecoration(
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      cursorColor: theme?[rootKey]?.color ?? defaultText,
      autocorrect: false,
      enableSuggestions: false,
      onChanged: (value) {
        setNumber(value);
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
}
