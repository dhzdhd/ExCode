import 'package:dio/dio.dart';
import 'package:excode/src/database/database.dart';

late final Dio dio;
late final Database database;

void initDioClient() {
  dio = Dio();
}

void initDatabase() {
  database = Database();
}
