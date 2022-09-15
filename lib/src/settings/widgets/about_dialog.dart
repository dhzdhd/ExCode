import 'package:flutter/material.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AboutDialog(
      applicationName: 'ExCode',
      applicationVersion: 'v0.0.2',
      applicationLegalese: 'MIT',
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text('Created by dhzdhd'),
        )
      ],
    );
  }
}
