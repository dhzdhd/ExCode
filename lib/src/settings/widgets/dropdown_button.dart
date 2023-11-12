import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StyledDropdownContainer extends ConsumerWidget {
  const StyledDropdownContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 160,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: child,
      ),
    );
  }
}
