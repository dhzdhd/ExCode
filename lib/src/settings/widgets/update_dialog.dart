import 'package:flutter/material.dart';

class InfoDialogWidget extends StatelessWidget {
  const InfoDialogWidget({Key? key, required this.isLatestVersion})
      : super(key: key);

  final bool isLatestVersion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Updates'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              isLatestVersion
                  ? 'Your app is upto date!'
                  : 'A new update is available!',
            ),
          ),
        ],
      ),
    );
  }
}
