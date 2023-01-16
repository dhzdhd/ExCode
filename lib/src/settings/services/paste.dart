import 'package:dio/dio.dart';
import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';

class CustomPasteBin {
  static const baseUrl = 'https://excode-pastebin.shuttleapp.rs';

  static Future<Either<String, String>> post(
      {required String lang, required String content}) async {
    if (content.trim().isEmpty) {
      return Either.left('Cannot make an empty paste!');
    }

    try {
      final res =
          await dio.post('$baseUrl/', data: {'lang': lang, 'content': content});

      final pasteUrl = '$baseUrl/${res.data["uuid"]!}';
      return Either.right(pasteUrl);
    } on DioError catch (_) {
      return Either.left('Error in making the paste!');
    }
  }
}
