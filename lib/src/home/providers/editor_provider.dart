import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorThemeStateProvider =
    StateNotifierProvider<_EditorNotifier, Map<String, dynamic>>(
        (ref) => _EditorNotifier());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel());

class _EditorNotifier extends StateNotifier<Map<String, dynamic>> {
  _EditorNotifier()
      : super({
          'language': allLanguages['python'],
          'theme': nordTheme,
          'langName': 'python',
        });

  void setLanguage(String language) {
    state = {
      ...state,
      'language': allLanguages[language],
      'langName': language
    };
  }

  void setTheme(Map<String, TextStyle> theme) {
    state = {
      ...state,
      'theme': theme,
    };
  }
}

class _EditorContentModel extends StateNotifier<String> {
  _EditorContentModel() : super('');

  void setContent(String content) {
    state = content;
  }

  void addContent(String content) {
    state = state + content;
  }

  void replaceAll(String old, String new_) {
    state = state.replaceAll(old, new_);
  }
}
