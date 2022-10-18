import 'package:excode/src/home/providers/output_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OutputWrapperWidget extends StatefulHookConsumerWidget {
  // final bool wideScreen;

  const OutputWrapperWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<OutputWrapperWidget> createState() =>
      _OutputWrapperWidgetState();
}

class _OutputWrapperWidgetState extends ConsumerState<OutputWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    // final selected = ref.watch(outputIsVisibleStateProvider);
    // final globalTheme = ref.watch(themeStateProvider);

    return const _OutputWidget();

    // ? Old implementation
    // return Positioned(
    //   height:
    //       selected ? MediaQuery.of(context).size.height - kToolbarHeight : 40,
    //   width: selected ? MediaQuery.of(context).size.width : 80,
    //   right: 0,
    //   top: selected ? 0 : 100,
    //   child: Dismissible(
    //     background: selected
    //         ? null
    //         : Container(
    //             color: globalTheme.accentColor,
    //           ),
    //     key: UniqueKey(),
    //     resizeDuration: const Duration(milliseconds: 2000),
    //     confirmDismiss: (direction) {
    //       if (direction == DismissDirection.endToStart) {
    //         ref.watch(outputIsVisibleStateProvider.notifier).showOutput();
    //       } else if (direction == DismissDirection.startToEnd) {
    //         ref.watch(outputIsVisibleStateProvider.notifier).hideOutput();
    //       }
    //       return Future.value(false);
    //     },
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.horizontal(
    //           left: Radius.circular(selected ? 0 : 20),
    //         ),
    //         color:
    //             selected ? globalTheme.secondaryColor : globalTheme.accentColor,
    //       ),
    //       child: Visibility(
    //         visible: selected,
    //         child: const _OutputWidget(),
    //         replacement: Padding(
    //           padding: const EdgeInsets.only(left: 8.0),
    //           child: Align(
    //             alignment: Alignment.centerLeft,
    //             child: Container(
    //               width: 30,
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child: const Icon(
    //                 Icons.arrow_back,
    //                 size: 30,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _OutputWidget extends ConsumerWidget {
  const _OutputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(futureOutputStateProvider);

    return provider.when(
      data: (data) => Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: ListView(
          children: [
            _OutputListItem(
                icon: Icons.code, title: 'Output', content: data['output']),
            _OutputListItem(
                icon: Icons.error, title: 'Error', content: data['err']),
          ],
        ),
      ),
      error: (err, st) => const SizedBox(
        child: Text('Error'),
      ),
      loading: () => const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _OutputListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _OutputListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon),
              title: Text(title),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 20),
                child: Text(content),
              ),
            )
          ],
        ),
      ),
    );
  }
}
