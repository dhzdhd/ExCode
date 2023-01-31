import 'package:excode/src/home/models/output_model.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final outputIsVisibleStateProvider =
    StateNotifierProvider<_OutputIsVisibleNotifier, bool>(
        (ref) => _OutputIsVisibleNotifier());
final outputIsLoadingProvider =
    StateNotifierProvider<_OutputIsLoadingNotifier, bool>(
        (ref) => _OutputIsLoadingNotifier());
final outputContentStateProvider =
    StateNotifierProvider<_OutputContentNotifier, OutputModel>(
        (ref) => _OutputContentNotifier(ref));
final futureOutputStateProvider = FutureProvider<OutputModel>((ref) async {
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

class _OutputContentNotifier extends StateNotifier<OutputModel> {
  final StateNotifierProviderRef<_OutputContentNotifier, OutputModel> ref;

  _OutputContentNotifier(this.ref)
      : super(const OutputModel(
          output: 'Execute code to see output',
          error: '-',
        ));

  Future<void> setOutput(Language lang, String content) async {
    ref.watch(outputIsLoadingProvider.notifier).setIsLoading();
    state = await ApiHandler.executeCode(lang, content);
    ref.watch(outputIsLoadingProvider.notifier).setIsLoading();
  }
}
