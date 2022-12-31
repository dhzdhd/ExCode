import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/snippet_model.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnippetService {
  static Future<void> store(
      {required List<SnippetModel> data, required Ref ref}) async {
    await box.put('snippetList', data.map((e) => e.toJson()).toList());

    final user = supabase.auth.currentUser;
    if (ref.read(settingsProvider).isSaveToCloud && user != null) {
      final res = await CloudDatabase.upsert(
        CloudModel(settings: ref.watch(settingsProvider), snippets: data),
        user.email!,
      );

      res.match((l) => print(l), (r) => print(r));
    }
  }

  static List<SnippetModel> fetch() {
    final List<dynamic>? dynamicList = box.get('snippetList');

    final storedCharList = dynamicList
        ?.map((e) => SnippetModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return storedCharList ??
        const [
          SnippetModel(name: '( )', value: '()', length: 1),
          SnippetModel(name: '{ }', value: '{}', length: 1),
          SnippetModel(name: '[ ]', value: '[]', length: 1),
          SnippetModel(name: '\\', value: '\\', length: 1),
          SnippetModel(name: "'", value: "''", length: 1),
          SnippetModel(name: '`', value: '``', length: 1),
          SnippetModel(name: '< >', value: '<>', length: 1),
        ];
  }
}
