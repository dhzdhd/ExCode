import 'package:excode/src/factory.dart';

class HasteBin {
  static Future<String> post(String content) async {
    final res = await dio.post('https://hastebin.com/documents', data: content);
    return 'https://hastebin.com/raw/${res.data["key"]!}';
  }
}
