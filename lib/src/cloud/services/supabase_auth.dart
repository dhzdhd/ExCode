import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ! Add TaskEither as .error was removed :(
class AuthService {
  static Future<Either<String, User?>> register(
      String email, String password) async {
    final response =
        await supabase.auth.signUp(email: email, password: password);

    return Right(response.user);
  }

  static Future<Either<String, User?>> signIn(
      String email, String password) async {
    final response = await supabase.auth
        .signInWithPassword(email: email, password: password);

    return Right(response.user);
  }

  static Future<Either<String, String>> signOut() async {
    final _ = await supabase.auth.signOut();

    return const Right('Successfully signed out!');
  }
}
