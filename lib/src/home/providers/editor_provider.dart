import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/char_model.dart';
import 'package:excode/src/home/services/language.dart';
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
final bottomBarButtonsStateProvider =
    StateNotifierProvider<_BottomBarButtonsModel, List<CharModel>>(
        (ref) => _BottomBarButtonsModel());

class _BottomBarButtonsModel extends StateNotifier<List<CharModel>> {
  _BottomBarButtonsModel()
      : super([
          const CharModel(name: '( )', value: '()', length: 1),
          const CharModel(name: '{ }', value: '{}', length: 1),
          const CharModel(name: '[ ]', value: '[]', length: 1),
          const CharModel(name: '"', value: '""', length: 1),
          const CharModel(name: '\'', value: '\'\'', length: 1),
          const CharModel(name: '`', value: '``', length: 1),
          const CharModel(name: '< >', value: '<>', length: 1),
        ]);

  void append(CharModel data) {
    state = state.append(data).toList();
  }

  void delete(String key) {
    state = state.filter((t) => t.name != key).toList();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final data = state.removeAt(oldIndex);
    state.insert(newIndex, data);
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
  _EditorContentModel(StateNotifierProviderRef<_EditorContentModel, String> ref)
      : super(box.get('${ref.watch(editorLanguageStateProvider)}code') ??
            langMap[ref.watch(editorLanguageStateProvider)]!.baseCode);

  void setContent(Option<String> content, [lang]) {
    // TODO: Find a better way to do this
    content.match((t) => state = t, () {
      final content = box.get('${lang}code') ?? langMap[lang]!.baseCode;
      state = content;
    });
  }

  Future<void> saveContent(String lang, String content) async {
    await box.put('${lang}code', content);
  }

  void addContent(String content, TextPosition pos) {
    state = state.substring(0, pos.offset) +
        content +
        state.substring(pos.offset, state.length);
  }

  void replaceAll(String old, String new_) {
    state = state.replaceAll(old, new_);
  }
}
