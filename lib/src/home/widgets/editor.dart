import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/widgets/code_field.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

class EditorWidget extends ConsumerStatefulWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends ConsumerState<EditorWidget> {
  late CodeController _controller;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = ref.watch(editorStateProvider);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        final theme = ref.watch(themeStateProvider);

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
              _CodeFieldWidget(controller: _controller),
              const OutputWrapperWidget(wideScreen: true)
            ],
          ),
        );
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
