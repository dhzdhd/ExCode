import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/char_model.dart';

class SnippetService {
  static Future<void> store({required List<CharModel> data}) async {
    await box.put('snippetList', data.map((e) => e.toJson()).toList());
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
