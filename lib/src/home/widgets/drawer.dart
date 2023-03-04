import 'package:dropdown_search/dropdown_search.dart';
import 'package:excode/src/factory.dart';
import 'package:excode/src/helpers.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/providers/editor_provider.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/home/services/api.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/views/home_view.dart';
import 'package:excode/src/home/widgets/file_rename_dialog.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends ConsumerStatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends ConsumerState<DrawerWidget> {
  late final TextEditingController _nameController;
  String language = 'python';

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
    final fileNotifier = ref.watch(filesProvider.notifier);
    final activeFile = ref.watch(activeFileProvider);

    return Drawer(
      backgroundColor: globalTheme.primaryColor,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            // floating: true,
            title: Text(
              appDocumentsDirectory.match(() => '', (t) => t.path),
              overflow: TextOverflow.fade,
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('New file'),
                          contentPadding: const EdgeInsets.all(24.0),
                          children: [
                            // ! Add validators
                            Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: TextFormField(
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
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 24.0),
                                    child: DropdownSearch<String>(
                                      // mode: Mode.MENU,
                                      // popupBackgroundColor:
                                      //     globalTheme.primaryColor,
                                      // showSearchBox: true,
                                      selectedItem: language,
                                      items: Language.values
                                          .map((e) => e.toString().substring(9))
                                          .toList(),
                                      itemAsString: (String? e) =>
                                          e.toString().capitalize(),
                                      onChanged: (val) {
                                        setState(() {
                                          language = val!;
                                        });
                                      },
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () async {
                                      await fileNotifier
                                          .add(
                                            name: _nameController.text,
                                            language: language,
                                          )
                                          .run()
                                          .then(
                                        (value) {
                                          value.match(
                                            (l) => context
                                                .showErrorSnackBar(l.message),
                                            (r) => context.showSuccessSnackBar(
                                              content:
                                                  'Successfully created file',
                                              action: const None(),
                                            ),
                                          );
                                          Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                              HomeView.routeName,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Submit'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: ref
                  .watch(filesProvider)
                  .map(
                    (e) => ListTile(
                      tileColor: globalTheme.secondaryColor,
                      selected: activeFile == Some(e),
                      selectedTileColor: globalTheme.accentColor,
                      title: Text(e.name),
                      subtitle: Text(e.language.capitalize()),
                      trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.adaptive.more,
                          color: activeFile == Some(e)
                              ? globalTheme.primaryColor
                              : null,
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Text('Save'),
                                  Spacer(),
                                  Icon(Icons.save)
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Text('Edit'),
                                  Spacer(),
                                  Icon(Icons.edit)
                                ],
                              ),
                              onTap: () {
                                Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        FileRenameDialogWidget(file: e),
                                  ),
                                );
                              },
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: const [
                                  Text('Delete'),
                                  Spacer(),
                                  Icon(Icons.delete)
                                ],
                              ),
                              onTap: () async {
                                await fileNotifier
                                    .remove(e)
                                    .run()
                                    .then((value) {
                                  value.match(
                                    (l) => context.showErrorSnackBar(l.message),
                                    (r) => context.showSuccessSnackBar(
                                      content: 'Successfully deleted file',
                                      action: const None(),
                                    ),
                                  );
                                });
                              },
                            ),
                          ];
                        },
                      ),
                      onTap: () {
                        ref
                            .watch(editorLanguageStateProvider.notifier)
                            .setLanguage(e.language);
                        ref
                            .watch(editorContentStateProvider.notifier)
                            .setContent(Some(e.content));
                        ref
                            .watch(activeFileProvider.notifier)
                            .set(file: Some(e));
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListTile(
              tileColor: globalTheme.secondaryColor,
              textColor: globalTheme.accentColor,
              style: ListTileStyle.list,
              title: const Text('No file mode'),
              onTap: () {
                ref.watch(activeFileProvider.notifier).set(file: const None());
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
