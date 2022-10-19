import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/input_model.dart';

class InputService {
  static Future<void> store({required InputModel data}) async {
    await box.put('inputArgs', data.toJsonString());
  }

  static InputModel fetch() {
    return InputModel.fromJsonString(
      box.get('inputArgs') ?? '''{"stdin": "hello","cmdline": "hi"}''',
    );
  }
}
