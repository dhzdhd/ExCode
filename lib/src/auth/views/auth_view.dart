import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthView extends ConsumerWidget {
  const AuthView({Key? key}) : super(key: key);
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: const Center(
          child: Text(
        'To be implemented!',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
