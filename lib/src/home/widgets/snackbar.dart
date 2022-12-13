import 'package:flutter/material.dart';

enum ActionState {
  success,
  error,
}

SnackBar snackBarWidget({
  required String content,
  required ActionState state,
  SnackBarAction? action,
}) {
  return SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    behavior: SnackBarBehavior.floating,
    backgroundColor: state == ActionState.success ? Colors.green : Colors.red,
    action: action,
  );
}
