import 'package:excode/src/cloud/models/cloud_model.dart';
import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/cloud/providers/cloud_provider.dart';
import 'package:excode/src/cloud/services/supabase_auth.dart';
import 'package:excode/src/cloud/services/supabase_db.dart';
import 'package:excode/src/cloud/views/auth_view.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/home/widgets/snackbar.dart';
import 'package:excode/src/settings/providers/settings_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthContainerWidget extends ConsumerWidget {
  const AuthContainerWidget({Key? key}) : super(key: key);

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
                      await CloudDatabase.upsert(
                          CloudModel(settings: ref.read(settingsProvider)),
                          supabase.auth.currentUser!.email!);

                      ref.watch(cloudProvider).map(
                            data: ((data) => print(data.value)),
                            error: ((error) => print(error.value)),
                            loading: ((loading) => print(loading)),
                          );
                    },
                    child: const Text('Sync data'),
                  ),
                ),
                Visibility(
                  visible: ref.watch(authProvider).user != null,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
