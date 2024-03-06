import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/factory.dart';
import 'package:fpdart/fpdart.dart';

// ! hasError was called on null error

class CloudDatabase {
  static const _databaseName = 'editor';

  static Future<Either<String, CloudModel>> upsert(
      CloudModel model, String email) async {
    final response = await supabase
        .from(_databaseName)
        .upsert({'email': email, 'data': model.toJson()});

    if (response.hasError) {
      return Left(response.error!.message);
    }

    try {
      final data = response.data[0] as Map<String, dynamic>;
      final model = CloudModel.fromJson(data['data']);
      return Right(model);
    } on RangeError catch (_) {
      return const Left('Data could not be sent to the cloud!');
    } catch (ex) {
      return Left(ex.toString());
    }
  }

  static TaskEither<String, CloudModel> fetch(String email) {
    return TaskEither.tryCatch(() async {
      final response = await supabase
          .from(_databaseName)
          .select()
          .filter('email', 'eq', email);

      print(response);
      final data = response[0] as Map<String, dynamic>;
      final model = CloudModel.fromJson(data['data']);
      return model;
    }, (error, stackTrace) {
      if (error is RangeError) {
        return 'Data not present on the cloud!';
      } else {
        return 'Error';
      }
    });
  }

  // * For testing only
  static TaskEither<String, List<dynamic>> fetchAll() {
    return TaskEither.tryCatch(() async {
      final response = await supabase.from(_databaseName).select();

      print(response);
      return response;
    }, (error, stackTrace) => error.toString());
  }

  // * For testing only
  static Future<Either<String, String>> delete(String email) async {
    final response =
        await supabase.from(_databaseName).delete().eq('email', email);

    if (response.hasError) {
      return Left(response.error!.message);
    }

    return Right(response.data); // ! Change to success message
  }
}
