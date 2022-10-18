import 'package:excode/src/home/services/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final outputIsVisibleStateProvider =
    StateNotifierProvider<_OutputIsVisibleNotifier, bool>(
        (ref) => _OutputIsVisibleNotifier());
final outputIsLoadingProvider =
    StateNotifierProvider<_OutputIsLoadingNotifier, bool>(
        (ref) => _OutputIsLoadingNotifier());
final outputContentStateProvider =
    StateNotifierProvider<_OutputContentNotifier, Map>(
        (ref) => _OutputContentNotifier(ref));
final futureOutputStateProvider = FutureProvider<Map>((ref) async {
  return ref.watch(outputContentStateProvider);
});

class _OutputIsVisibleNotifier extends StateNotifier<bool> {
  _OutputIsVisibleNotifier() : super(false);

  void showOutput() {
    state = true;
  }

  void hideOutput() {
    state = false;
  }
}

class _OutputIsLoadingNotifier extends StateNotifier<bool> {
  _OutputIsLoadingNotifier() : super(false);

  void setIsLoading() {
    state = !state;
  }
}

class _OutputContentNotifier extends StateNotifier<Map> {
  final StateNotifierProviderRef<_OutputContentNotifier, Map<dynamic, dynamic>>
      ref;

  _OutputContentNotifier(this.ref)
      : super({'output': 'Execute code to see output', 'err': '-'});

  Future<void> setOutput(Languages lang, String content) async {
    ref.watch(outputIsLoadingProvider.notifier).setIsLoading();
    state = await ApiHandler.executeCode(lang, content);
    ref.watch(outputIsLoadingProvider.notifier).setIsLoading();
  }
}
