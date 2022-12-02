import 'package:excode/src/factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutDialog(
      applicationName: 'ExCode',
      // ! Make less obfuscated
      applicationVersion: (defaultTargetPlatform == TargetPlatform.windows)
          ? null
          : kIsWeb
              ? 'Latest'
              : 'v${packageInfo.version}',
      applicationLegalese: 'MIT',
      children: const [
        Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text('Created by dhzdhd'),
        )
      ],
    );
  }
}
