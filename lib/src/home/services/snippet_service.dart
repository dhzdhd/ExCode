import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/char_model.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnippetService {
  static Future<void> store(
      {required List<CharModel> data, required Ref ref}) async {
    await box.put('snippetList', data.map((e) => e.toJson()).toList());

    final user = supabase.auth.currentUser;
    if (ref.watch(settingsProvider).isSaveToCloud && user != null) {
      final res = await CloudDatabase.upsert(
        CloudModel(settings: ref.watch(settingsProvider), snippets: data),
        user.email!,
      );

      res.match((l) => print(l), (r) => print(r));
    }
  }

  static List<CharModel> fetch() {
    final List<dynamic>? dynamicList = box.get('snippetList');

    final storedCharList = dynamicList
        ?.map((e) => CharModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return storedCharList ??
        const [
          CharModel(name: '( )', value: '()', length: 1),
          CharModel(name: '{ }', value: '{}', length: 1),
          CharModel(name: '[ ]', value: '[]', length: 1),
          CharModel(name: '\\', value: '\\', length: 1),
          CharModel(name: "'", value: "''", length: 1),
          CharModel(name: '`', value: '``', length: 1),
          CharModel(name: '< >', value: '<>', length: 1),
        ];
  }
}
