import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';

class CustomPasteBin {
  static const baseUrl = 'https://excode-pastebin.shuttleapp.rs/';

  static Future<Either<String, String>> post(String content) async {
    if (content.trim().isEmpty) {
      return Either.left('Cannot make an empty paste!');
    }

    try {
      final res =
          await dio.post('https://hastebin.com/documents', data: content);
      return Either.right('https://hastebin.com/${res.data["key"]!}');
    } catch (err) {
      return Either.left('Error in making hastebin paste!');
    }
  }
}
