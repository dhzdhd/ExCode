import 'dart:convert';

import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDropDownWidget extends ConsumerWidget {
  const AuthDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);
    final user = ref.watch(authStateProvider).user;
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
                    child: const Text('Login'),
                    onTap: (() {}),
                  ),
                if (user != null)
                  PopupMenuItem(
                    child: const Text('User info'),
                    onTap: (() async {
                      // ? Future added so as to not pop dialog instantly when opened
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
                  ),
                if (user != null)
                  PopupMenuItem(
                    child: const Text('Sync data'),
                    onTap: (() {}),
                  ),
                if (user != null)
                  PopupMenuItem(
                    child: const Text('Sign out'),
                    onTap: (() {}),
                  ),
              ];
            }),
            child: user == null
                ? const Icon(Icons.person, size: size)
                : SvgPicture.network(
                    'https://avatars.dicebear.com/api/bottts/${email!}.svg',
                    width: size,
                  ),
          ),
        ),
      ),
    );
  }
}
