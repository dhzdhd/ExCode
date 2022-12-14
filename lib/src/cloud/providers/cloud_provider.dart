import 'dart:async';

import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudProvider =
    AsyncNotifierProvider<_CloudNotifier, CloudModel>(() => _CloudNotifier());

class _CloudNotifier extends AsyncNotifier<CloudModel> {
  @override
  FutureOr<CloudModel> build() async {
    final res = await supabase.from('settings').select('*').execute();
    return CloudModel.fromJson(res.data);
  }

  void setData() {
    update((oldState) => oldState);
  }
}
