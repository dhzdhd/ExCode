import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/snippet_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SnippetService {
  static Future<void> store(
      {required List<SnippetModel> data, required Ref ref}) async {
    await box.put('snippetList', data.map((e) => e.toJson()).toList());
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
