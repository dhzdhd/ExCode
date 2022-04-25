import 'package:dio/dio.dart';

late final Dio dio;

void initDioClient() {
  dio = Dio();
}
