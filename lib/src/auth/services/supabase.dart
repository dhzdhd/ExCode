import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  static late final SupabaseClient sbClient;

  static void initCloudStorage() {
    sbClient = SupabaseClient(
      'https://vkncfbjgekuolcmqompg.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZrbmNmYmpnZWt1b2xjbXFvbXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjUyNDc5ODAsImV4cCI6MTk4MDgyMzk4MH0.nlfU0EoD_ZFHsjwlWDPJcGaDl0yU5Hfr3CUfVJyInwY',
    );
  }

  static Future<Either<String, User?>> register(
      String email, String password) async {
    final response = await sbClient.auth.signUp(email, password);

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return Right(response.user);
    }
  }

  static Future<Either<String, User?>> signIn(
      String email, String password) async {
    final response =
        await sbClient.auth.signIn(email: email, password: password);

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return Right(response.user);
    }
  }

  static Future<Either<String, String>> signOut() async {
    final response = await sbClient.auth.signOut();

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return const Right('Successfully signed out!');
    }
  }
}
