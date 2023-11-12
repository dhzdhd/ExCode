import 'dart:isolate';
import 'dart:ui';

import 'package:excode/src/settings/services/update_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class InfoDialogWidget extends StatefulWidget {
  const InfoDialogWidget({super.key, required this.isLatestVersion});

  final bool isLatestVersion;

  @override
  State<InfoDialogWidget> createState() => _InfoDialogWidgetState();
}

class _InfoDialogWidgetState extends State<InfoDialogWidget> {
  final ReceivePort _port = ReceivePort();
  DownloadTaskStatus status = DownloadTaskStatus.undefined;
  int progress = 0;
  String id = '';

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {
        id = data[0];
        status = data[1];
        progress = data[2];
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
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
          visible: !widget.isLatestVersion &&
              (defaultTargetPlatform == TargetPlatform.android),
          child: ElevatedButton(
            onPressed: () async {
              await FlutterDownloader.enqueue(
                url: UpdateService.latestVersionUrl,
                headers: {},
                savedDir: '/storage/emulated/0/Download',
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              );
            },
            child: (status == DownloadTaskStatus.running)
                ? TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress.toDouble()),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator.adaptive(value: value),
                      );
                    },
                  )
                : const Text('Update'),
          ),
        ),
      ],
    );
  }
}
