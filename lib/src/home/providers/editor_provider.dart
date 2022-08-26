import 'package:excode/src/factory.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorLanguageStateProvider =
    StateNotifierProvider<_EditorLanguageNotifier, String>(
        (ref) => _EditorLanguageNotifier());
final editorThemeStateProvider =
    StateNotifierProvider<_EditorThemeNotifier, Map<String, TextStyle>>(
        (ref) => _EditorThemeNotifier());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel(ref));

class _EditorLanguageNotifier extends StateNotifier<String> {
  _EditorLanguageNotifier() : super(box.get('editorLanguage') ?? 'python');

  void setLanguage(String language) {
    box.put('editorLanguage', language);
    state = language;
  }
}

class _EditorThemeNotifier extends StateNotifier<Map<String, TextStyle>> {
  _EditorThemeNotifier() : super(box.get('editorTheme') ?? nordTheme);

  void setTheme(Map<String, TextStyle> theme) {
    box.put('editorTheme', theme);
    state = theme;
  }
}

class _EditorContentModel extends StateNotifier<String> {
  _EditorContentModel(StateNotifierProviderRef<_EditorContentModel, String> ref)
      : super(box.get('${ref.watch(editorLanguageStateProvider)}code') ??
            langMap[ref.watch(editorLanguageStateProvider)]!.baseCode);

  void setContent(String content) {
    state = content;
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
