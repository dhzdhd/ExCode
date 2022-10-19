import 'dart:convert';

class InputModel {
  final String stdInArgs;
  final String cmdLineArgs;

  const InputModel({required this.stdInArgs, required this.cmdLineArgs});

  String toJsonString() {
    final map = {'stdin': stdInArgs, 'cmdline': cmdLineArgs};
    return const JsonEncoder().convert(map);
  }

  static InputModel fromJsonString(String json) {
    final map = const JsonDecoder().convert(json);
    return InputModel(
      stdInArgs: map['stdin'],
      cmdLineArgs: map['cmdline'],
    );
  }
}
