import 'package:code_text_field/code_text_field.dart';
import 'package:excode/src/home/models/char_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/widgets/code_field.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:highlight/highlight.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

class EditorWidget extends StatefulHookConsumerWidget {
  const EditorWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<EditorWidget> createState() => _EditorWidgetState();
}

class _EditorWidgetState extends ConsumerState<EditorWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  void tabListener() {
    if (_tabController.index == 0) {
      ref.watch(outputIsVisibleStateProvider.notifier).hideOutput();
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeStateProvider);
    final editorTheme = ref.watch(editorLanguageStateProvider);
    final content = ref.watch(editorContentStateProvider);

    ref.listen(outputIsVisibleStateProvider, ((previous, next) {
      if (ref.watch(outputIsVisibleStateProvider) == true) {
        _tabController.animateTo(1);
      }
    }));

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
                theme: langThemeMap[
                    getEnumFromString(ref.watch(editorThemeStateProvider))]!,
                lang: langMap[editorTheme]!.mode,
                content: content,
              ),
              const OutputWrapperWidget()
            ],
          ),
        );
      }
      return Column(
        children: [
          if (ref.watch(tabVisibilityProvider))
            TabBar(
              tabs: const [Tab(text: 'Code'), Tab(text: 'Output')],
              controller: _tabController,
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _CodeFieldWidget(
                  theme: langThemeMap[
                      getEnumFromString(ref.watch(editorThemeStateProvider))]!,
                  lang: langMap[editorTheme]!.mode,
                  content: content,
                ),
                const OutputWrapperWidget(),
              ],
            ),
          )
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
    CharModel(name: '( )', value: '()', length: 1),
    CharModel(name: '{ }', value: '{}', length: 1),
    CharModel(name: '[ ]', value: '[]', length: 1),
    CharModel(name: '"', value: '""', length: 1),
    CharModel(name: '\'', value: '\'\'', length: 1),
    CharModel(name: '`', value: '``', length: 1),
    CharModel(name: '< >', value: '<>', length: 1),
  ];

  var _selection = 0;

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
      _focusNode.requestFocus();
      _controller.selection = _controller.selection
          .copyWith(baseOffset: _selection, extentOffset: _selection);
    }
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
        Column(
          children: [
            Expanded(
              child: CodeFieldWidget(
                enabled: !ref.watch(lockProvider),
                focusNode: _focusNode,
                textStyle: TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: ref.watch(fontSizeProvider)),
                controller: _controller,
                onChanged: (value) => ref
                    .watch(editorContentStateProvider.notifier)
                    .setContent(Some(value)),
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
                      if (!ref.watch(lockProvider)) {
                        final spaces = ref.watch(tabSpaceProvider).space;
                        _selection =
                            _controller.selection.baseOffset + spaces.length;
                        ref
                            .watch(editorContentStateProvider.notifier)
                            .addContent(
                              spaces,
                              _controller.selection.base,
                            );
                      }
                    },
                    child: const Text('TAB'),
                  ),
                  ...charModelList.map(
                    (e) => TextButton(
                      onPressed: () {
                        if (!ref.watch(lockProvider)) {
                          _selection =
                              _controller.selection.baseOffset + e.length;
                          ref
                              .watch(editorContentStateProvider.notifier)
                              .addContent(e.value, _controller.selection.base);
                        }
                      },
                      child: Text(e.name),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Visibility(
          visible: ref.watch(lockProvider),
          child: Center(
              child: Icon(
            Icons.lock,
            color: Colors.white.withOpacity(0.3),
            size: 50,
          )),
        ),
      ],
    );
  }
}
