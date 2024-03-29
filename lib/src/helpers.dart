import 'package:excode/src/home/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

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
      action: action.toNullable(),
    ));
  }

  void showErrorSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(snackBarWidget(
      content: content,
      state: SnackBarState.error,
    ));
  }
}
