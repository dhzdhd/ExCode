import 'package:excode/src/factory.dart';
import 'package:excode/src/home/models/file_model.dart';
import 'package:excode/src/home/providers/file_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: const Text('New file'),
                        contentPadding:
                            const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                        children: [
                          Form(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: globalTheme.accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: globalTheme.accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: globalTheme.accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                  onPressed: null, child: const Text('Submit'))
                            ],
                          ))
                        ],
                      ),
                    ),
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
