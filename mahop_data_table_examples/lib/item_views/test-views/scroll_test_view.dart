import 'package:flutter/material.dart';

import '../../utils/example_view.dart';

class ScrollTestView extends StatefulWidget {
  const ScrollTestView({super.key});

  @override
  State<ScrollTestView> createState() => _ScrollTestViewState();
}

class _ScrollTestViewState extends State<ScrollTestView> {
  var scrollControllerHor = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ExampleView(
      header: "Flutter Test Scroll",
      code: "",
      help: const SizedBox(),
      child: buildScrollTester(context),
    );
  }

  Widget buildScrollTester(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      interactive: true,
      controller: scrollControllerHor,
      thickness: 12.0,
      child: ListView(
        controller: scrollControllerHor,
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.red)),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 200, height: 200, color: Colors.green)),
        ],
      ),
    );
  }
}
