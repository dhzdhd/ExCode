import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CloudStorage {
  static late final SupabaseClient sbClient;

  static void initCloudStorage() {
    sbClient = SupabaseClient('', '');
  }

  Future<Either<String, String>> register(String email, String password) async {
    // try {
    // } on  catch (err) {
    //   if (err.code == 'weak-password') {
    //     return const Left('Password provided is too weak!');
    //   } else if (err.code == 'email-already-in-use') {
    //     return const Left(
    //         'This account already exists for the email provided.');
    //   }
    // } catch (err) {
    //   return Left(err.toString());
    // }
    return const Right('Successfully registered!');
  }

  Future<Either<String, String>> signIn(String email, String password) async {
    // try {

    // } on  catch (err) {
    //   if (err.code == 'user-not-found') {
    //     return const Left('No user found for the provided email!');
    //   } else if (err.code == 'email-already-in-use') {
    //     return const Left('Wrong password provided!');
    //   }
    // } catch (err) {
    //   return Left(err.toString());
    // }
    return const Right('Successfully registered!');
  }

  Future<Either<String, String>> signOut() async {
    try {} catch (err) {
      return Left(err.toString());
    }
    return const Right('Successfully signed out!');
  }
}
