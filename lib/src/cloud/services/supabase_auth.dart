import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  // ! Switch to returning success string
  static Future<Either<String, User?>> register(
      String email, String password) async {
    final response = await supabase.auth.signUp(email, password);

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return Right(response.user);
    }
  }

  static Future<Either<String, User?>> signIn(
      String email, String password) async {
    final response =
        await supabase.auth.signIn(email: email, password: password);

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return Right(response.user);
    }
  }

  static Future<Either<String, String>> signOut() async {
    final response = await supabase.auth.signOut();

    if (response.error != null) {
      return Left(response.error!.message);
    } else {
      return const Right('Successfully signed out!');
    }
  }
}
