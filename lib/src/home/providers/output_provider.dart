import 'package:hooks_riverpod/hooks_riverpod.dart';

final outputIsVisibleStateProvider =
    StateNotifierProvider<_OutputIsVisibleNotifier, bool>(
        (ref) => _OutputIsVisibleNotifier());
final outputStateProvider = StateNotifierProvider<_OutputContentModel, Map>(
    (ref) => _OutputContentModel());

class _OutputIsVisibleNotifier extends StateNotifier<bool> {
  _OutputIsVisibleNotifier() : super(false);

  void showOutput() {
    state = true;
  }

  void hideOutput() {
    state = false;
  }
}

class _OutputContentModel extends StateNotifier<Map> {
  _OutputContentModel()
      : super({'output': 'Execute code to see output', 'err': '-'});

  void setOutput(Map<String, String> data) {
    state = data;
  }
}