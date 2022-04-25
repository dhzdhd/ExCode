import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/widgets/code_field.dart';
import 'package:excode/src/home/widgets/output.dart';
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
    final editorTheme = ref.watch(editorThemeStateProvider);

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
            minimalWeight: 0.2,
            children: [
              _CodeFieldWidget(
                theme: editorTheme['theme'],
                lang: editorTheme['language'],
                text: ref.watch(editorContentStateProvider),
              ),
              const OutputWrapperWidget(wideScreen: true)
            ],
          ),
        );
      }
      return Stack(
        children: [
          _CodeFieldWidget(
            theme: editorTheme['theme'],
            lang: editorTheme['language'],
            text: ref.watch(editorContentStateProvider),
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
  final String text;

  const _CodeFieldWidget(
      {Key? key, required this.theme, required this.lang, required this.text})
      : super(key: key);

  @override
  ConsumerState<_CodeFieldWidget> createState() => _CodeFieldWidgetState();
}

class _CodeFieldWidgetState extends ConsumerState<_CodeFieldWidget> {
  late final CodeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: widget.text,
      theme: widget.theme,
      language: widget.lang,
    );
  }

  @override
  void didUpdateWidget(_CodeFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != _controller.theme ||
        widget.lang != _controller.language ||
        widget.text != _controller.text) {
      _controller = CodeController(
        text: widget.text,
        theme: widget.theme,
        language: widget.lang,
      );
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
            textStyle: const TextStyle(fontFamily: 'FiraCode'),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: ref.watch(themeStateProvider).invertedColor,
              selectionHandleColor: ref.watch(themeStateProvider).primaryColor,
            ),
            controller: _controller,
            onChanged: (value) => ref
                .watch(editorContentStateProvider.notifier)
                .setContent(value),
            expands: true,
          ),
        ),
        SizedBox(
          height: 20,
          child: Row(
            children: [TextButton(onPressed: () {}, child: const Text('TAB'))],
          ),
        )
      ],
    );
  }
}
