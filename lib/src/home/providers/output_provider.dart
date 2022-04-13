import 'package:hooks_riverpod/hooks_riverpod.dart';

final outputStateProvider =
    StateNotifierProvider<_OutputModel, String>((ref) => _OutputModel());

class _OutputModel extends StateNotifier<String> {
  _OutputModel() : super('');
}
