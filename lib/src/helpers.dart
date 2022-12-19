import 'package:excode/src/home/widgets/snackbar.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    if (this.isNotEmpty) {
      return '${this[0].toUpperCase()}${this.substring(1)}';
    }
    return '';
  }
}

extension ShowSnackBar on BuildContext {
  void showSuccessSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(snackBarWidget(
      content: content,
      state: SnackBarState.success,
    ));
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
