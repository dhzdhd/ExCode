import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReplaceDialogWidget extends ConsumerStatefulWidget {
  const ReplaceDialogWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  ConsumerState<ReplaceDialogWidget> createState() =>
      _ReplaceDialogWidgetState();
}

class _ReplaceDialogWidgetState extends ConsumerState<ReplaceDialogWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contentNotifier = ref.read(editorContentStateProvider.notifier);

    return SimpleDialog(
      title: const Text('Replace text'),
      contentPadding: const EdgeInsets.all(24),
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Replace ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: widget.text),
              const TextSpan(
                text: ' with',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'New text'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: OutlinedButton(
            child: const Text('Submit'),
            onPressed: () {
              contentNotifier.replaceAll(widget.text, _controller.text);
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
