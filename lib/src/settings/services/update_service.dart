import 'package:excode/src/factory.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

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

  static Future<void> download() async {
    await FlutterDownloader.enqueue(
      url: 'your download link', // !
      savedDir: 'the path of directory where you want to save downloaded files',
      showNotification: true,
      openFileFromNotification: true,
    );
  }
}
