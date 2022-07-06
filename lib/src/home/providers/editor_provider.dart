import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/lang_model.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorThemeStateProvider =
    StateNotifierProvider<_EditorNotifier, LangModel>(
        (ref) => _EditorNotifier());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel());

class _EditorNotifier extends StateNotifier<LangModel> {
  _EditorNotifier()
      : super(LangModel(
          mode: allLanguages['python']!,
          name: 'python',
          style: nordTheme,
        ));

  void setLanguage(String language) {
    box.put('lang', language);
    state = LangModel(
      mode: allLanguages[language]!,
      name: language,
      style: state.style,
    );
  }

  void setTheme(Map<String, TextStyle> theme) {
    state = LangModel(mode: state.mode, name: state.name, style: theme);
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
