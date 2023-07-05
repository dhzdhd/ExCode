import 'package:excode/src/helpers.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FileRenameDialogWidget extends ConsumerStatefulWidget {
  const FileRenameDialogWidget({Key? key, required this.file})
      : super(key: key);

  final FileModel file;

  @override
  ConsumerState<FileRenameDialogWidget> createState() =>
      _FileRenameDialogWidgetState();
}

class _FileRenameDialogWidgetState
    extends ConsumerState<FileRenameDialogWidget> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = ref.watch(themeStateProvider);
    final fileNotifier = ref.read(filesProvider.notifier);

    return SimpleDialog(
      title: const Text('Rename file'),
      contentPadding: const EdgeInsets.all(24.0),
      children: [
        Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: const Text('File name'),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: globalTheme.accentColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: OutlinedButton(
                  onPressed: () async {
                    await fileNotifier
                        .rename(widget.file, _nameController.text)
                        .run()
                        .then((value) {
                      value.match(
                        (l) => context.showErrorSnackBar(l.message),
                        (r) => context.showSuccessSnackBar(
                          content: 'Successfully renamed file',
                          action: const None(),
                        ),
                      );
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
