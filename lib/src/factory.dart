import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

late final Dio dio;
late Box box;

void initDioClient() {
  dio = Dio();
}

void initDatabase() async {
  await Hive.initFlutter();
  box = await Hive.openBox('code');
}
