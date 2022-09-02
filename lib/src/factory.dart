import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

late final Dio dio;
late final Box box;
late final PackageInfo packageInfo;

void initDioClient() {
  dio = Dio();
}

Future<void> initDatabase() async {
  await Hive.initFlutter();
  box = await Hive.openBox('code');
}

Future<void> initPackageInfo() async {
  packageInfo = await PackageInfo.fromPlatform();
}
