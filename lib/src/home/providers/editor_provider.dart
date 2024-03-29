import 'package:excode/src/cloud/services/cloud_store.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/models/snippet_model.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/services/snippet_service.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorLanguageStateProvider =
    StateNotifierProvider<_EditorLanguageNotifier, String>(
        (ref) => _EditorLanguageNotifier());
final editorThemeStateProvider =
    StateNotifierProvider<_EditorThemeNotifier, String>(
        (ref) => _EditorThemeNotifier());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel(ref));
final cursorSelectionStateProvider =
    StateNotifierProvider<_CursorSelectionModel, int>(
        (ref) => _CursorSelectionModel());
final snippetBarStateProvider =
    StateNotifierProvider<_SnippetBarModel, List<SnippetModel>>(
        (ref) => _SnippetBarModel(ref));
final matchTextStateProvider =
    StateNotifierProvider<_MatchTextModel, Map<String, TextStyle>>(
        (ref) => _MatchTextModel());

class _MatchTextModel extends StateNotifier<Map<String, TextStyle>> {
  _MatchTextModel() : super({});

  final _style = const TextStyle(
    backgroundColor: Colors.amber,
    color: Colors.black,
  );

  void reset() {
    state = {};
  }

  void addPattern({required String pattern}) {
    state = {pattern: _style};
  }
}

class _SnippetBarModel extends StateNotifier<List<SnippetModel>> {
  final StateNotifierProviderRef<_SnippetBarModel, List<SnippetModel>> ref;

  // ? Maybe use a ChangeNotifierProvider?
  _SnippetBarModel(this.ref) : super(SnippetService.fetch());

  Future<void> append(SnippetModel data) async {
    state = [...state, data];
    await SnippetService.store(data: state, ref: ref);
    await saveToCloud(settings: const None(), snippets: Some(state), ref: ref);
  }

  Future<void> setState(List<SnippetModel> newState) async {
    state = newState;

    await SnippetService.store(data: newState, ref: ref);
  }

  Future<void> edit(
      {required SnippetModel oldData, required SnippetModel newData}) async {
    final index = state.indexOf(oldData);
    List<SnippetModel> temp = List.from(state);
    temp.removeAt(index);
    temp.insert(index, newData);

    state = temp;
    await SnippetService.store(data: state, ref: ref);
    await saveToCloud(settings: const None(), snippets: Some(state), ref: ref);
  }

  Future<void> delete(String key) async {
    state = state.filter((t) => t.name != key).toList();
    await SnippetService.store(data: state, ref: ref);
    await saveToCloud(settings: const None(), snippets: Some(state), ref: ref);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    List<SnippetModel> temp = List.from(state);
    final data = temp.removeAt(oldIndex);
    temp.insert(newIndex, data);

    state = temp;
    await SnippetService.store(data: temp, ref: ref);
    await saveToCloud(settings: const None(), snippets: Some(state), ref: ref);
  }
}

class _CursorSelectionModel extends StateNotifier<int> {
  _CursorSelectionModel() : super(0);

  void setCursorSelection(int selection) {
    state = selection;
  }
}

class _EditorLanguageNotifier extends StateNotifier<String> {
  _EditorLanguageNotifier() : super(box.get('editorLanguage') ?? 'python');

  void setLanguage(String language) {
    box.put('editorLanguage', language);
    state = language;
  }
}

class _EditorThemeNotifier extends StateNotifier<String> {
  _EditorThemeNotifier() : super(box.get('editorTheme') ?? 'nord');

  Future<void> setTheme(String theme) async {
    await box.put('editorTheme', theme);
    state = theme;
  }
}

class _EditorContentModel extends StateNotifier<String> {
  _EditorContentModel(this.ref)
      : super(box.get('${ref.watch(editorLanguageStateProvider)}code') ??
            getLangFromName(ref.watch(editorLanguageStateProvider)).template);

  final StateNotifierProviderRef<_EditorContentModel, String> ref;

  void setContent(Option<String> content, [String? lang]) {
    // TODO Find a better way to do this
    content.match(
      () {
        final content =
            box.get('${lang}code') ?? getLangFromName(lang!).template;
        state = content;
      },
      (t) => state = t,
    );
  }

  Future<void> saveContent(String lang, String content) async {
    ref.watch(activeFileProvider).match(
          () async => await box.put('${lang}code', content),
          (t) async => await ref
              .watch(filesProvider.notifier)
              .save(FileModel(
                name: t.name,
                content: content,
                language: t.language,
                ext: t.ext,
                path: t.path,
              ))
              .run(),
        );
  }

  void addContent(String content, TextPosition pos) {
    final offset = pos.offset == -1 ? 0 : pos.offset;
    if (pos.offset > state.length) {
      state = state + content;
    } else {
      state = state.substring(0, offset) +
          content +
          state.substring(offset, state.length);
    }
  }

  void replaceAll(String old, String new_) {
    state = state.replaceAll(old, new_);
  }
}
