import 'package:excode/src/home/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

abstract class AppError {
  final String _message;

  AppError(this._message);

  String get message => _message;
}

extension StringExtension on String {
  String capitalize() {
    if (this.isNotEmpty) {
      return '${this[0].toUpperCase()}${this.substring(1)}';
    }
    return '';
  }
}

extension ShowSnackBar on BuildContext {
  void showSuccessSnackBar(
      {required String content, required Option<SnackBarAction> action}) {
    ScaffoldMessenger.of(this).showSnackBar(snackBarWidget(
        content: content,
        state: SnackBarState.success,
        action: action.toNullable()));
  }

  void showErrorSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(snackBarWidget(
      content: content,
      state: SnackBarState.error,
    ));
  }
}

extension Match<T> on Object? {
  T match(T Function() a, T Function() b) {
    if (this == null) {
      return b();
    }
    return a();
  }
}

void a() {
  int? a = 5;
  a.match(() => print('Not null'), () => print('Null'));
}
