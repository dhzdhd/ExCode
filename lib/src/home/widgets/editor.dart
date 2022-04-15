import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/widgets/code_field.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return Consumer(builder: (_, WidgetRef ref, __) {
          final provider = ref.watch(themeStateProvider);

          return MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerPainter: DividerPainters.grooved1(
                backgroundColor: provider.primaryColor,
                color: provider.invertedColor,
                highlightedColor: provider.invertedColor,
              ),
            ),
            child: MultiSplitView(
              minimalWeight: 0.2,
              children: [
                _CodeFieldWidget(controller: _controller),
                const OutputWrapperWidget(wideScreen: true)
              ],
            ),
          );
        });
      }
      return Stack(
        children: [
          _CodeFieldWidget(controller: _controller),
          const OutputWrapperWidget(wideScreen: false),
        ],
      );
    });
  }
}

class _CodeFieldWidget extends ConsumerWidget {
  const _CodeFieldWidget({
    Key? key,
    required CodeController controller,
  })  : _controller = controller,
        super(key: key);

  final CodeController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: CodeFieldWidget(
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
