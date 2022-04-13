import 'dart:math';

import 'package:excode/src/home/providers/output_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OutputWrapperWidget extends StatefulWidget {
  final bool wideScreen;

  const OutputWrapperWidget({Key? key, required this.wideScreen})
      : super(key: key);

  @override
  State<OutputWrapperWidget> createState() => _OutputWrapperWidgetState();
}

class _OutputWrapperWidgetState extends State<OutputWrapperWidget> {
  var selected = false;
  var pressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.wideScreen) {
      return const _OutputWidget();
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      height: selected ? MediaQuery.of(context).size.height : 130,
      width: selected ? MediaQuery.of(context).size.width : 30,
      right: pressed ? 10 : 0,
      top: selected ? 0 : 100,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! < -5 && !selected) {
            setState(() {
              selected = true;
            });
          } else if (details.primaryDelta! > 5 && selected) {
            setState(() {
              selected = false;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(selected ? 0 : 5),
            ),
            color: Colors.blueAccent,
          ),
          child: Visibility(
            visible: selected,
            child: const _OutputWidget(),
            replacement: const Icon(Icons.arrow_left_sharp),
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

    return ListView(
      children: [
        _OutputListItem(
            icon: Icons.code, title: 'Output', content: data['output']),
        _OutputListItem(
            icon: Icons.error, title: 'Error', content: data['err']),
      ],
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
    return Card(
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
    );
  }
}
