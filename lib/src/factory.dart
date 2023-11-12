import 'dart:io';

import 'package:dio/dio.dart';
import 'package:excode/src/settings/services/update_service.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late final Dio dio;
late final Box box;
late final PackageInfo packageInfo;
late final SupabaseClient supabase;
late final Option<Directory> appDocumentsDirectory;

void initDioClient() {
  dio = Dio();
}

Future<void> initCloudStorage() async {
  await Supabase.initialize(
    url: 'https://vkncfbjgekuolcmqompg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrbmNmYmpnZWt1b2xjbXFvbXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjUyNDc5ODAsImV4cCI6MTk4MDgyMzk4MH0.nlfU0EoD_ZFHsjwlWDPJcGaDl0yU5Hfr3CUfVJyInwY',
  );
  supabase = Supabase.instance.client;
}

Future<void> initDatabase() async {
  await Hive.initFlutter();
  box = await Hive.openBox('code');
}

Future<void> initPackageInfo() async {
  packageInfo = await PackageInfo.fromPlatform();
  await UpdateService.initVersion();
}

Future<void> initDownloader() async {
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
}

Future<void> initFileStorage() async {
  if (kIsWeb) {
    appDocumentsDirectory = const None();
  } else {
    final directory = await getApplicationDocumentsDirectory();

    try {
      final docDir = await directory.create();
      // ! Change to URI
      appDocumentsDirectory =
          Some(await Directory(docDir.path + '/ExCode').create());
    } catch (e) {
      appDocumentsDirectory = const None();
    }
  }
}
