import 'package:flutter/material.dart';

import '../utils/example_view.dart';

class ToDoView extends StatelessWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExampleView(
      header: "ToDo",
      code: "",
      help: Center(
        child: Text(""),
      ),
      child: Center(
        child: Text("Sorry - sample not done yet - we work hard!!!"),
      ),
    );
  }
}
