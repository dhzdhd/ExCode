import 'package:excode/src/factory.dart';
import 'package:excode/src/helpers.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/home/services/language.dart';
import 'package:excode/src/home/views/home_view.dart';
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
  late final TextEditingController _languageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _languageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalTheme = ref.watch(themeStateProvider);
    final fileNotifier = ref.watch(filesProvider.notifier);

    return Drawer(
      backgroundColor: globalTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: Text(
              appDocumentsDirectory.match((t) => t.path, () => ''),
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
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
                                // ! Change to dropdown menu (implemented in appbar)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: TextFormField(
                                    controller: _languageController,
                                    decoration: InputDecoration(
                                      label: const Text('Language'),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: globalTheme.accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    await fileNotifier
                                        .add(FileModel(
                                          name: _nameController.text,
                                          content:
                                              langMap[_languageController.text]!
                                                  .template,
                                          language: _languageController.text,
                                        ))
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
                                                HomeView.routeName));
                                      },
                                    );
                                  },
                                  child: const Text('Submit'),
                                )
                              ],
                            ))
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
          SliverList(
            delegate: SliverChildListDelegate(
              ref
                  .watch(filesProvider)
                  .map(
                    (e) => ListTile(
                      tileColor: globalTheme.secondaryColor,
                      title: Text(e.name),
                      subtitle: Text(e.language),
                      trailing: PopupMenuButton(
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
                            )
                          ];
                        },
                      ),
                      onTap: () => print('hi'),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
