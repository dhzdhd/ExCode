import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_model.freezed.dart';
part 'input_model.g.dart';

@freezed
class InputModel with _$InputModel {
  const factory InputModel({
    required String stdInArgs,
    required String cmdLineArgs,
  }) = _InputModel;

  factory InputModel.fromJson(Map<String, dynamic> json) =>
      _$InputModelFromJson(json);
}

// import 'dart:convert';

// class InputModel {
//   final String stdInArgs;
//   final String cmdLineArgs;

//   const InputModel({required this.stdInArgs, required this.cmdLineArgs});

//   String toJsonString() {
//     final map = {'stdin': stdInArgs, 'cmdline': cmdLineArgs};
//     return const JsonEncoder().convert(map);
//   }

//   static InputModel fromJsonString(String json) {
//     final map = const JsonDecoder().convert(json);
//     return InputModel(
//       stdInArgs: map['stdin'],
//       cmdLineArgs: map['cmdline'],
//     );
//   }
// }
