import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/cloud/services/supabase_auth.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/cloud/views/auth_view.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/helpers.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@Deprecated('Use AuthDropDownWidget instead')
class AuthContainerWidget extends ConsumerWidget {
  const AuthContainerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 500,
      child: Container(
        color: ref.watch(themeStateProvider).primaryColor,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Text(
              ref.watch(authProvider).user?.email ?? 'Not signed in yet!',
              // .match((t) => t.email!, () => 'Not signed in yet!'),
              style: const TextStyle(fontSize: 20),
            ),
            Visibility(
              visible: ref.watch(authProvider).user == null,
              child: TextButton(
                onPressed: () {
                  Navigator.restorablePushNamed(context, AuthView.routeName);
                },
                child: const Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: ref.watch(authProvider).user != null,
                  child: TextButton(
                    onPressed: () async {
                      final res = await CloudDatabase.fetch(
                        supabase.auth.currentUser!.email!,
                      ).run();
                      res.match((l) => context.showErrorSnackBar(l), (r) {
                        ref
                            .watch(settingsProvider.notifier)
                            .setState(r.settings);
                        ref
                            .watch(snippetBarStateProvider.notifier)
                            .setState(r.snippets);
                        context.showSuccessSnackBar(
                          content: 'Successfully synced data!',
                          action: const None(),
                        );
                      });
                    },
                    child: const Text('Sync data'),
                  ),
                ),
                Visibility(
                  visible: ref.watch(authProvider).user != null,
                  child: TextButton(
                    onPressed: () async {
                      final response = await AuthService.signOut();
                      response.match(
                        (l) => context.showErrorSnackBar(l),
                        (r) => context.showSuccessSnackBar(
                          content: r,
                          action: const None(),
                        ),
                      );
                    },
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
