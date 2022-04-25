import 'package:excode/src/home/providers/output_provider.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OutputWrapperWidget extends StatefulHookConsumerWidget {
  final bool wideScreen;

  const OutputWrapperWidget({Key? key, required this.wideScreen})
      : super(key: key);

  @override
  ConsumerState<OutputWrapperWidget> createState() =>
      _OutputWrapperWidgetState();
}

class _OutputWrapperWidgetState extends ConsumerState<OutputWrapperWidget> {
  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);
    var selected = ref.watch(outputIsVisibleStateProvider);

    if (widget.wideScreen) {
      return const _OutputWidget();
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      height:
          selected ? MediaQuery.of(context).size.height - kToolbarHeight : 40,
      width: selected ? MediaQuery.of(context).size.width : 70,
      right: pressed.value ? 10 : 0,
      top: selected ? 0 : 100,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! < -5 && !selected) {
            ref.watch(outputIsVisibleStateProvider.notifier).showOutput();
          } else if (details.primaryDelta! > 5 && selected) {
            ref.watch(outputIsVisibleStateProvider.notifier).hideOutput();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(selected ? 0 : 20),
            ),
            color: selected ? ThemeData.dark().primaryColor : accentColor,
          ),
          child: Visibility(
            visible: selected,
            child: const _OutputWidget(),
            replacement: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutputWidget extends ConsumerWidget {
  const _OutputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(outputStateProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: ListView(
        children: [
          _OutputListItem(
              icon: Icons.code, title: 'Output', content: data['output']),
          _OutputListItem(
              icon: Icons.error, title: 'Error', content: data['err']),
        ],
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
