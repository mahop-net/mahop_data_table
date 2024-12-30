import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  final Widget help;
  final Function showCode;

  const HelpView({super.key, required this.help, required this.showCode});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Expanded(child: widget.help),
              ],
            ),
          ),
        ),
        Positioned(
            top: 5,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: OutlinedButton(
                onPressed: () => widget.showCode(),
                child: const Text("View code"),
              ),
            )),
      ],
    );
  }
}
