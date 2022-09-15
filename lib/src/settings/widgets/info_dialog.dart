import 'package:excode/src/settings/services/update_service.dart';
import 'package:flutter/foundation.dart';
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
          if (defaultTargetPlatform == TargetPlatform.android &&
              !isLatestVersion &&
              false)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: TextButton(
                  onPressed: () async {
                    await UpdateService.download();
                  },
                  child: const Text('Download updated version'),
                ),
              ),
            )
        ],
      ),
    );
  }
}
