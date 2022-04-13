import 'package:hooks_riverpod/hooks_riverpod.dart';

final outputStateProvider =
    StateNotifierProvider<_OutputModel, Map>((ref) => _OutputModel());
final editorContentStateProvider =
    StateNotifierProvider<_EditorContentModel, String>(
        (ref) => _EditorContentModel());

class _OutputModel extends StateNotifier<Map> {
  _OutputModel() : super({'output': '', 'err': ''});

  void setOutput(Map<String, String> data) {
    state = data;
  }
}

class _EditorContentModel extends StateNotifier<String> {
  _EditorContentModel() : super('');

  void setContent(String content) {
    state = content;
  }
}
