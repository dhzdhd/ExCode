import 'dart:isolate';
import 'dart:ui';

import 'package:excode/src/settings/services/settings_service.dart';
import 'package:excode/src/settings/services/update_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class InfoDialogWidget extends StatefulWidget {
  const InfoDialogWidget({Key? key, required this.isLatestVersion})
      : super(key: key);

  final bool isLatestVersion;

  @override
  State<InfoDialogWidget> createState() => _InfoDialogWidgetState();
}

class _InfoDialogWidgetState extends State<InfoDialogWidget> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // ! Implement loader
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

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
            widget.isLatestVersion
                ? 'Your app is upto date!'
                : 'A new update is available!',
          )),
        ],
      ),
      actions: [
        Visibility(
          visible: widget.isLatestVersion &&
              (defaultTargetPlatform == TargetPlatform.android), // !
          child: ElevatedButton(
            onPressed: () async {
              print(UpdateService.latestVersionUrl);
              await FlutterDownloader.enqueue(
                url: UpdateService.latestVersionUrl,
                headers: {},
                savedDir: '/storage/emulated/0/Download',
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              );
            },
            child: const Text('Update'),
          ),
        ),
      ],
    );
  }
}
