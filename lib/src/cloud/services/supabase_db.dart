import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';

class CloudDatabase {
  static const _databaseName = 'editor';

  static Future<Either<String, CloudModel>> upsert(
      CloudModel model, String email) async {
    final response = await supabase
        .from(_databaseName)
        .upsert({'email': email, 'data': model.toJson()}).execute();
    if (response.hasError) {
      return Left(response.error!.message);
    }
    // print(response.data[0]); // ! remove and prettify
    return Right(CloudModel.fromJson(
        (response.data[0] as Map<String, dynamic>)['data']));
  }

  static Future<Either<String, CloudModel>> fetch(String email) async {
    final response = await supabase
        .from(_databaseName)
        .select()
        .filter('email', 'eq', email)
        .execute();

    if (response.hasError) {
      print(response.error!.message);
      return Left(response.error!.message);
    }

    // ! prettify
    return Right(CloudModel.fromJson(
        (response.data[0] as Map<String, dynamic>)['data']));
  }
}

// class CloudDatabase {
//   static Future<Either<String, String>> fetch(String email) async {
//     final response = await supabase.from('settings').select().execute();

//     if (response.hasError) {
//       return Left(response.error!.message);
//     }

//     print(response.toJson());
//     return Right(response.data);
//   }

//   static Future<Either<String, String>> upsert(
//       String email, String data) async {
//     final response = await supabase.from('settings').upsert(data).execute();

//     if (response.hasError) {
//       return Left(response.error!.message);
//     }

//     print(response.data);
//     return Right(response.data);
//   }
// }
