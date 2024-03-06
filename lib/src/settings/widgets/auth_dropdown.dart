import 'dart:convert';

import 'package:excode/src/cloud/models/cloud_model.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDropDownWidget extends ConsumerWidget {
  const AuthDropDownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);
    final user = ref.watch(authProvider).user;
    final email = user == null
        ? null
        : const Base64Encoder().convert(user.email!.codeUnits);
    const double size = 40;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxHeight: size),
        decoration: BoxDecoration(
            border: Border.all(color: globalTheme.accentColor),
            borderRadius: BorderRadius.circular(size / 2)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          clipBehavior: Clip.hardEdge,
          child: PopupMenuButton(
            tooltip: 'Profile settings',
            position: PopupMenuPosition.under,
            itemBuilder: ((context) {
              return [
                if (user == null)
                  PopupMenuItem(
                    onTap: (() {
                      // * Future added so as to not pop dialog instantly when opened
                      Future.delayed(
                        const Duration(seconds: 0),
                        () => Navigator.restorablePushNamed(
                          context,
                          AuthView.routeName,
                        ),
                      );
                    }),
                    child: const Text('Login'),
                  ),
                if (user != null)
                  PopupMenuItem(
                    onTap: (() async {
                      Future.delayed(
                        const Duration(seconds: 0),
                        () => showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: SelectableText(user.email!),
                            );
                          }),
                        ),
                      );
                    }),
                    child: const Text('User info'),
                  ),
                if (user != null)
                  PopupMenuItem(
                    onTap: (() async {
                      final res = await CloudDatabase.fetch(user.email!).run();
                      res.match(
                        (l) => context.showErrorSnackBar(l),
                        (r) async {
                          await ref
                              .watch(settingsProvider.notifier)
                              .setState(r.settings);
                          await ref
                              .watch(snippetBarStateProvider.notifier)
                              .setState(r.snippets);

                          // ! Move to a save to cloud service file
                          final user = supabase.auth.currentUser;
                          if (ref.watch(settingsProvider).isSaveToCloud &&
                              user != null) {
                            // final res =
                            await CloudDatabase.upsert(
                              CloudModel(
                                settings: ref.watch(settingsProvider),
                                snippets: ref.watch(snippetBarStateProvider),
                              ),
                              user.email!,
                            );
                            // res.match((l) => print(l), (r) => print(r));
                          }

                          if (context.mounted) {
                            context.showSuccessSnackBar(
                              content: 'Successfully synced data!',
                              action: const None(),
                            );
                          }
                        },
                      );
                    }),
                    child: const Text('Sync data'),
                  ),
                if (user != null)
                  PopupMenuItem(
                    onTap: (() async {
                      final response = await AuthService.signOut();
                      response.match(
                        (l) => context.showErrorSnackBar(l),
                        (r) => context.showSuccessSnackBar(
                          content: r,
                          action: const None(),
                        ),
                      );
                    }),
                    child: const Text('Sign out'),
                  ),
              ];
            }),
            child: user == null
                ? const Icon(Icons.person, size: size)
                : SvgPicture.network(
                    'https://api.dicbear.com/7.x/bottts/svg?seed=$email',
                    width: size,
                    placeholderBuilder: (ctx) =>
                        const Icon(Icons.person, size: size),
                  ),
          ),
        ),
      ),
    );
  }
}
