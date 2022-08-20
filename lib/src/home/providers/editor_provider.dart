import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/lang_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorLanguageStateProvider =
    StateNotifierProvider<_EditorLanguageNotifier, LangModel>(
        (ref) => _EditorLanguageNotifier());
final editorThemeStateProvider =
    StateNotifierProvider<_EditorThemeNotifier, Map<String, TextStyle>>(
        (ref) => _EditorThemeNotifier());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel());

class _EditorLanguageNotifier extends StateNotifier<LangModel> {
  _EditorLanguageNotifier()
      : super(LangModel(
          mode: allLanguages[box.get('editorLanguage')] ??
              allLanguages['python']!,
          name: box.get('editorLanguage') ?? 'python',
        ));

  void setLanguage(String language) {
    box.put('editorLanguage', language);
    state = LangModel(
      mode: allLanguages[language] ?? allLanguages['python']!,
      name: language,
    );
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
  _EditorContentModel() : super(box.get('code') ?? '');

  void setContent(String content) {
    state = content;
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
