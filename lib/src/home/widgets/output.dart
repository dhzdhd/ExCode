import 'dart:math';

import 'package:flutter/material.dart';

class OutputWidget extends StatefulWidget {
  const OutputWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OutputWidget> createState() => _OutputWidgetState();
}

class _OutputWidgetState extends State<OutputWidget> {
  var selected = false;
  var pressed = false;

  @override
  Widget build(BuildContext context) {
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
            child: const Text('HELELLEOO'),
            replacement: const Icon(Icons.arrow_left_sharp),
          ),
        ),
      ),
    );
  }
}
