import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_highlight/themes/nord.dart';
import 'package:highlight/languages/all.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final editorStateProvider = StateNotifierProvider<_EditorModel, CodeController>(
    (ref) => _EditorModel());

class _EditorModel extends StateNotifier<CodeController> {
  _EditorModel()
      : super(
            CodeController(language: allLanguages['python'], theme: nordTheme));

  void setLanguage(String language) {
    state = CodeController(
      language: allLanguages[language],
      theme: state.theme,
      text: state.text,
      onChange: state.onChange,
    );
  }

  void setTheme(Map<String, TextStyle> theme) {
    state = CodeController(
        language: state.language, theme: theme, text: state.text);
  }
}
