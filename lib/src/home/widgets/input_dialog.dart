import 'package:excode/src/helpers.dart';
import 'package:excode/src/home/models/input_model.dart';
import 'package:excode/src/home/services/input_service.dart';
import 'package:flutter/material.dart';

class InputDialogWidget extends StatefulWidget {
  const InputDialogWidget({Key? key}) : super(key: key);

  @override
  State<InputDialogWidget> createState() => _InputDialogWidgetState();
}

class _InputDialogWidgetState extends State<InputDialogWidget> {
  late final InputModel _data;
  late final TextEditingController _stdinController;
  late final TextEditingController _cmdLineController;

  @override
  void initState() {
    _data = InputService.fetch();
    _stdinController = TextEditingController(text: _data.stdInArgs);
    _cmdLineController = TextEditingController(text: _data.cmdLineArgs);
    super.initState();
  }

  @override
  void dispose() {
    _stdinController.dispose();
    _cmdLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('STDIN and command line arguments'),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
      children: [
        // TODO: Add validators
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: TextFormField(
            controller: _stdinController,
            decoration: const InputDecoration(labelText: 'STDIN arguments'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: TextFormField(
            controller: _cmdLineController,
            decoration:
                const InputDecoration(labelText: 'Command line arguments'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await InputService.store(
                  data: InputModel(
                    stdInArgs: _stdinController.text,
                    cmdLineArgs: _cmdLineController.text,
                  ),
                );

                Navigator.of(context).pop();
                context.showSuccessSnackBar('Successfully saved input data!');
              },
              child: const Text('Save'),
            ),
          ),
        )
      ],
    );
  }
}
