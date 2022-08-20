import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/models/char_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/widgets/bottom_bar.dart';
import 'package:excode/src/home/widgets/code_field.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:highlight/highlight.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

class EditorWidget extends ConsumerWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeStateProvider);
    final editorTheme = ref.watch(editorLanguageStateProvider);
    final content = ref.watch(editorContentStateProvider);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.grooved1(
              backgroundColor: theme.primaryColor,
              color: theme.invertedColor,
              highlightedColor: theme.invertedColor,
            ),
          ),
          child: MultiSplitView(
            initialAreas: [
              Area(weight: 0.7, minimalWeight: 0.2),
              Area(weight: 0.3, minimalWeight: 0.2),
            ],
            children: [
              _CodeFieldWidget(
                theme: ref.watch(editorThemeStateProvider),
                lang: editorTheme.mode,
                content: content,
              ),
              const OutputWrapperWidget(wideScreen: true)
            ],
          ),
        );
      }
      return Stack(
        children: [
          _CodeFieldWidget(
            theme: ref.watch(editorThemeStateProvider),
            lang: editorTheme.mode,
            content: content,
          ),
          const OutputWrapperWidget(wideScreen: false),
        ],
      );
    });
  }
}

class _CodeFieldWidget extends StatefulHookConsumerWidget {
  final Map<String, TextStyle> theme;
  final Mode lang;
  final String content;

  const _CodeFieldWidget({
    Key? key,
    required this.theme,
    required this.lang,
    required this.content,
  }) : super(key: key);

  @override
  ConsumerState<_CodeFieldWidget> createState() => _CodeFieldWidgetState();
}

class _CodeFieldWidgetState extends ConsumerState<_CodeFieldWidget> {
  late final FocusNode _focusNode;
  late CodeController _controller;
  static const charModelList = [
    CharModel(name: '( )', value: '()'),
    CharModel(name: '{ }', value: '{}'),
    CharModel(name: '[ ]', value: '[]'),
    CharModel(name: '"', value: '""'),
    CharModel(name: '\'', value: '\'\''),
    CharModel(name: '`', value: '``'),
    CharModel(name: '< >', value: '<>'),
  ];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = CodeController(
      theme: widget.theme,
      language: widget.lang,
      text: widget.content,
    );
  }

  @override
  void didUpdateWidget(_CodeFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != _controller.theme ||
        widget.lang != _controller.language ||
        widget.content != _controller.text) {
      _controller = CodeController(
        text: widget.content,
        theme: widget.theme,
        language: widget.lang,
      );
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.selection.base.offset));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CodeFieldWidget(
            focusNode: _focusNode,
            textStyle: const TextStyle(fontFamily: 'FiraCode'),
            controller: _controller,
            onChanged: (value) => ref
                .watch(editorContentStateProvider.notifier)
                .setContent(value),
            expands: true,
            wrap: ref.watch(settingsProvider),
          ),
        ),
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TextButton(
                onPressed: () {
                  ref.watch(editorContentStateProvider.notifier).addContent(
                        ref.watch(tabSpaceProvider).space,
                        _controller.selection.base,
                      );
                },
                child: const Text('TAB'),
              ),
              ...charModelList.map(
                (e) => TextButton(
                  onPressed: () {
                    ref
                        .watch(editorContentStateProvider.notifier)
                        .addContent(e.value, _controller.selection.base);
                    _focusNode.requestFocus();
                  },
                  child: Text(e.name),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
