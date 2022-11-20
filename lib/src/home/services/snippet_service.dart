import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/char_model.dart';

class SnippetService {
  static Future<void> store({required List<CharModel> data}) async {
    await box.put('snippetList', CharModelSerialisable.toJsonString(data));
  }

  static List<CharModel> fetch() {
    return CharModelSerialisable.fromJsonString(
      box.get('snippetList') ??
          '''[
          {"name": "( )", "value": "()", "length": 1},
          {"name": "{ }", "value": "{}", "length": 1},
          {"name": "[ ]", "value": "[]", "length": 1},
          {"name": "\\"", "value": "\\"\\"", "length": 1},
          {"name": "'", "value": "''", "length": 1},
          {"name": "`", "value": "``", "length": 1},
          {"name": "< >", "value": "<>", "length": 1}
        ]''',
    );
  }
}
