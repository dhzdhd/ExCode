import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/cloud/services/supabase_auth.dart';
import 'package:excode/src/cloud/views/auth_view.dart';
import 'package:excode/src/home/widgets/snackbar.dart';
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
            ref.watch(authProvider)?.email ?? 'Not signed in yet!',
            style: const TextStyle(fontSize: 20),
          ),
          Visibility(
            visible: ref.watch(authProvider) == null,
            child: TextButton(
              onPressed: () {
                Navigator.restorablePushNamed(context, AuthView.routeName);
              },
              child: const Text('Login'),
            ),
          ),
          Visibility(
            visible: ref.watch(authProvider) != null,
            child: TextButton(
              onPressed: () async {
                final response = await Auth.signOut();
                response.match(
                  (l) => ScaffoldMessenger.of(context).showSnackBar(
                    snackBarWidget(
                      content: l,
                      state: ActionState.error,
                    ),
                  ),
                  (r) => ScaffoldMessenger.of(context).showSnackBar(
                    snackBarWidget(
                      content: r,
                      state: ActionState.success,
                    ),
                  ),
                );
              },
              child: const Text('Sign Out'),
            ),
          )
        ],
      ),
    );
  }
}
