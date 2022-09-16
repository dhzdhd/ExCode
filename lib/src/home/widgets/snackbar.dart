import 'package:flutter/material.dart';

enum State {
  success,
  error,
}

SnackBar snackBarWidget({required String content, required State state}) {
  return SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    behavior: SnackBarBehavior.floating,
    backgroundColor: state == State.success ? Colors.green : Colors.red,
  );
}
