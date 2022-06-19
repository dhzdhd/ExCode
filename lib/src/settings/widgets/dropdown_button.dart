import 'package:flutter/material.dart';

class StyledDropdownContainer extends StatelessWidget {
  const StyledDropdownContainer({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: child,
        ),
      ),
    );
  }
}
