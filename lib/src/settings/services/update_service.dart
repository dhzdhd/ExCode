import 'package:excode/src/factory.dart';

class UpdateService {
  static late final String _latestVersion;
  static late final String _latestVersionUrl;

  static String get latestVersion => _latestVersion;
  static String get latestVersionUrl => _latestVersionUrl;

  static Future<void> initVersion() async {
    final res = await dio
        .get<List>('https://api.github.com/repos/dhzdhd/ExCode/releases');
    _latestVersion = res.data![0]['tag_name']!;

    final List assetData = res.data![0]['assets']!;
    _latestVersionUrl = assetData
        .where((element) => element['name'] == 'app.apk')
        .toList()[0]['browser_download_url'];
  }

  static bool isLatestVersion() {
    return _latestVersion.substring(1) == packageInfo.version;
  }
}
