import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalTheme = ref.watch(themeStateProvider);

    return Drawer(
      backgroundColor: globalTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            title: Row(
              children: const [
                IconButton(onPressed: null, icon: Icon(Icons.add)),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  tileColor: globalTheme.secondaryColor,
                  title: Text('main'),
                  subtitle: Text('Python'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            child: IconButton(
                          icon: Icon(Icons.save),
                          onPressed: null,
                        ))
                      ];
                    },
                  ),
                  onTap: () => print('hi'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
