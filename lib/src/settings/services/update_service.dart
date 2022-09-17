import 'package:excode/src/factory.dart';

class UpdateService {
  static late final String _latestVersion;

  static String get latestVersion => _latestVersion;

  static Future<void> initVersion() async {
    final res =
        await dio.get('https://api.github.com/repos/dhzdhd/ExCode/releases');
    _latestVersion = res.data[0]['tag_name'];
  }

  static bool isLatestVersion() {
    return _latestVersion.substring(1) == packageInfo.version;
  }
}
