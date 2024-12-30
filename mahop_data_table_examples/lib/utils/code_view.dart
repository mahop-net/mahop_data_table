import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:highlight/languages/dart.dart';

class CodeView extends StatefulWidget {
  final String code;
  final Function showHelp;

  const CodeView({super.key, required this.code, required this.showHelp});

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  @override
  Widget build(BuildContext context) {
    var controller = CodeController(
      text: widget.code, // Initial code
      language: dart,
      readOnly: true,
    );

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
            child: CodeTheme(
              data: CodeThemeData(styles: vsTheme),
              child: SingleChildScrollView(
                child: CodeField(
                  textStyle: const TextStyle(color: Colors.white),
                  background: Theme.of(context).colorScheme.surface,
                  controller: controller,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () => widget.showHelp(),
                    child: const Text("View help"),
                  ),
                  const SizedBox(width: 5),
                  OutlinedButton(
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: widget.code)),
                    child: const Icon(Icons.copy),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
