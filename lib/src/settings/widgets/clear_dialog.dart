import 'package:excode/src/factory.dart';
import 'package:flutter/material.dart';

class ClearDialogWidget extends StatelessWidget {
  const ClearDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Clear local storage'),
      content: const Text(
          'This clears all the settings and code stored locally and reverts the app to defaults when reopened.\nAre you sure you want to do this?'),
      actions: [
        ElevatedButton(
            onPressed: () async {
              try {
                await box.deleteFromDisk();
              } finally {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Confirm')),
        ElevatedButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
