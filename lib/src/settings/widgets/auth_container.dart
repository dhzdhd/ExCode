import 'package:excode/src/auth/providers/auth_provider.dart';
import 'package:excode/src/auth/views/auth_view.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthContainerWidget extends ConsumerWidget {
  const AuthContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ref.watch(themeStateProvider).primaryColor,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Text(
            ref.watch(authProvider)?.toString() ?? 'Not signed in yet!',
            style: const TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              Navigator.restorablePushNamed(context, AuthView.routeName);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
