import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';

class HasteBin {
  static Future<Either<String, String>> post(String content) async {
    if (content.trim().isEmpty) {
      return Either.left('Cannot make an empty paste!');
    }

    final res = await dio.post('https://hastebin.com/documents', data: content);
    return Either.right('https://hastebin.com/raw/${res.data["key"]!}');
  }
}
