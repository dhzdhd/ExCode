import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/input_model.dart';

class InputService {
  static Future<void> store({required InputModel data}) async {
    await box.put('inputArgs', data.toJson());
  }

  static InputModel fetch() {
    return InputModel.fromJson(
      Map<String, dynamic>.from(
        box.get('inputArgs') ?? {'stdInArgs': '0', 'cmdLineArgs': '0'},
      ),
    );
  }
}
