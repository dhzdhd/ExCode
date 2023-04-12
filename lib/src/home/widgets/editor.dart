import 'package:desktop_drop/desktop_drop.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/widgets/drag_drop_dialog.dart';
import 'package:excode/src/home/widgets/output.dart';
import 'package:excode/src/home/widgets/replace_dialog.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:excode/src/home/widgets/snippet_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
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
    if (_tabController.index == 1) {
      ref.watch(outputIsVisibleStateProvider.notifier).showOutput();
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
    final language = ref.watch(editorLanguageStateProvider);
    final content = ref.watch(editorContentStateProvider);
    final isTabBarVisible =
        ref.watch(settingsProvider.select((value) => value.isTabBarVisible));
    final patternMap = ref.watch(matchTextStateProvider);

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
                lang: getLangFromName(language).mode,
                content: content,
                patternMap: patternMap,
              ),
              const OutputWrapperWidget()
            ],
          ),
        );
      }
      return Column(
        children: [
          if (isTabBarVisible)
            TabBar(
              tabs: const [Tab(text: 'Code'), Tab(text: 'Output')],
              controller: _tabController,
              labelColor: theme.invertedColor,
              indicatorColor: theme.accentColor,
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _CodeFieldWidget(
                  theme: langThemeMap[
                      getEnumFromString(ref.watch(editorThemeStateProvider))]!,
                  lang: getLangFromName(language).mode,
                  content: content,
                  patternMap: patternMap,
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
  final Map<String, TextStyle> patternMap;

  const _CodeFieldWidget({
    Key? key,
    required this.theme,
    required this.lang,
    required this.content,
    required this.patternMap,
  }) : super(key: key);

  @override
  ConsumerState<_CodeFieldWidget> createState() => _CodeFieldWidgetState();
}

class _CodeFieldWidgetState extends ConsumerState<_CodeFieldWidget> {
  late final FocusNode _focusNode;
  late CodeController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = CodeController(
      language: widget.lang,
      text: widget.content,
      patternMap: widget.patternMap,
    );
  }

  @override
  void didUpdateWidget(_CodeFieldWidget oldWidget) {
    final _selection = ref.watch(cursorSelectionStateProvider);

    super.didUpdateWidget(oldWidget);
    if (widget.lang != _controller.language ||
        widget.content != _controller.text ||
        widget.patternMap != _controller.patternMap) {
      _controller = CodeController(
        text: widget.content,
        language: widget.lang,
        patternMap: widget.patternMap,
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
    final isLocked =
        ref.watch(settingsProvider.select((value) => value.isLocked));
    final fontSize =
        ref.watch(settingsProvider.select((value) => value.fontSize));
    final isWordWrapped =
        ref.watch(settingsProvider.select((value) => value.isWordWrapped));
    final matchTextNotifier = ref.watch(matchTextStateProvider.notifier);
    final matchTextMap = ref.watch(matchTextStateProvider);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DropTarget(
                onDragDone: (detail) async {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return const DragDropDialogWidget();
                    }),
                  );
                },
                // * Old implementation
                // child: CodeFieldWidget(
                //   enabled: !isLocked,
                //   focusNode: _focusNode,
                //   textStyle:
                //       TextStyle(fontFamily: 'FiraCode', fontSize: fontSize),
                //   controller: _controller,
                //   onChanged: (value) => ref
                //       .watch(editorContentStateProvider.notifier)
                //       .setContent(Some(value)),
                //   wrap: isWordWrapped,
                // ),
                child: CodeTheme(
                  data: CodeThemeData(styles: widget.theme),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      // Line height * Number of lines + Extra space
                      height:
                          fontSize * 3 * _controller.text.split('\n').length +
                              2000,
                      child: CodeField(
                        // ! Add text matching
                        controller: _controller,
                        wrap: isWordWrapped,
                        enabled: !isLocked,
                        focusNode: _focusNode,
                        expands: true,
                        maxLines: null,
                        textStyle: TextStyle(
                            fontFamily: 'FiraCode', fontSize: fontSize),
                        gutterStyle: GutterStyle(
                          textStyle: TextStyle(
                            fontFamily: 'FiraCode',
                            fontSize: fontSize,
                            height: 1.5,
                          ),
                          width: 80,
                          margin: 5,
                        ),
                        onChanged: (value) => ref
                            .watch(editorContentStateProvider.notifier)
                            .setContent(Some(value)),
                        contextMenuBuilder: (context, editableTextState) {
                          final TextEditingValue value =
                              editableTextState.textEditingValue;
                          final List<ContextMenuButtonItem> buttonItems =
                              editableTextState.contextMenuButtonItems;

                          final selectedText =
                              value.selection.textInside(value.text);

                          if (selectedText.isNotEmpty) {
                            buttonItems.addAll([
                              ContextMenuButtonItem(
                                label: matchTextMap.isEmpty
                                    ? 'Find'
                                    : 'Reset matching',
                                onPressed: () {
                                  if (matchTextMap.isEmpty) {
                                    matchTextNotifier.addPattern(
                                      pattern: selectedText,
                                    );
                                  } else {
                                    matchTextNotifier.reset();
                                  }
                                },
                              ),
                              ContextMenuButtonItem(
                                label: 'Replace all instances',
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ReplaceDialogWidget(text: selectedText),
                                  );
                                },
                              ),
                            ]);
                          }

                          return AdaptiveTextSelectionToolbar.buttonItems(
                            anchors: editableTextState.contextMenuAnchors,
                            buttonItems: buttonItems,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SnippetBarWidget(controller: _controller)
          ],
        ),
        Visibility(
          visible: isLocked,
          child: Center(
              child: Icon(
            Icons.lock,
            color: ref.watch(themeStateProvider).invertedColor.withOpacity(0.3),
            size: 50,
          )),
        ),
      ],
    );
  }
}
