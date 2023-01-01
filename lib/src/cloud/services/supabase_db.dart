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

    try {
      final data = response.data[0] as Map<String, dynamic>;
      final model = CloudModel.fromJson(data['data']);
      return Right(model);
    } on RangeError catch (_) {
      return const Left('Data could not be sent to the cloud!');
    } catch (ex) {
      print(ex);
      return Left(ex.toString());
    }
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

    try {
      final data = response.data[0] as Map<String, dynamic>;
      final model = CloudModel.fromJson(data['data']);
      return Right(model);
    } on RangeError catch (_) {
      return const Left('Data not present on the cloud!');
    } catch (ex) {
      print(ex);
      return const Left('error');
    }
  }

  // * For testing only
  static Future<Either<String, List<dynamic>>> fetchAll() async {
    final response = await supabase.from(_databaseName).select().execute();

    if (response.hasError) {
      return Left(response.error!.message);
    }

    return Right(response.data);
  }

  // * For testing only
  static Future<Either<String, String>> delete(String email) async {
    final response = await supabase
        .from(_databaseName)
        .delete()
        .eq('email', email)
        .execute();

    if (response.hasError) {
      return Left(response.error!.message);
    }

    return Right(response.data); // ! Change to success message
  }
}
