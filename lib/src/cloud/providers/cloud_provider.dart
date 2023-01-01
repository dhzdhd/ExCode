import 'dart:async';

import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cloudProvider =
    AsyncNotifierProvider<_CloudNotifier, CloudModel>(() => _CloudNotifier());

class _CloudNotifier extends AsyncNotifier<CloudModel> {
  // * built only once
  @override
  FutureOr<CloudModel> build() async {
    final response =
        await CloudDatabase.fetch(supabase.auth.currentUser!.email!);
    return response.match(
      (l) {
        print('left');
        print(l);
        final model = CloudModel(
          settings: ref.read(settingsProvider),
          snippets: ref.read(snippetBarStateProvider),
        );
        print(model.toJson());
        return model;
      },
      (r) {
        print('right');
        print(r);
        return r;
      },
    );
  }

  void setData() {
    update((oldState) => oldState);
  }
}
