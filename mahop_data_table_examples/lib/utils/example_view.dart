import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mahop_data_table_examples/utils/help_view.dart';
import 'package:split_view/split_view.dart';

import '../main.dart';
import 'code_view.dart';

enum ViewModes { auto, none, help, code }

class ExampleView extends StatefulWidget {
  final Widget child;
  final Widget help;
  final String code;
  final String header;

  const ExampleView(
      {super.key,
      this.header = "",
      required this.help,
      required this.code,
      required this.child});

  @override
  State<ExampleView> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  bool? _showHelp;
  bool _showCode = false;
  ViewModes viewMode = ViewModes.auto;
  UnmodifiableListView<double?> weight =
      UnmodifiableListView<double?>([0.7, 0.3]);
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    _themeMode = MainApp.of(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(widget.header),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.menu),
          //   tooltip: 'menu',
          //   onPressed: () {
          //     setState(() {
          //       if (_showHelp == null) {
          //         _showHelp = !_helpIsShown;
          //       } else {
          //         _showHelp = !(_showHelp == true);
          //       }
          //     });
          //   },
          // ),
          const Padding(
              padding: EdgeInsets.all(16.0), child: Text("Brightness:")),
          SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.light, label: Text('Light')),
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark, label: Text('Dark')),
              ButtonSegment<ThemeMode>(
                  value: ThemeMode.system, label: Text('System')),
            ],
            selected: <ThemeMode>{_themeMode},
            onSelectionChanged: (Set<ThemeMode> themeMode) {
              setState(() {
                _themeMode = themeMode.first;
                MainApp.of(context).changeTheme(_themeMode);
              });
            },
          ),
          const SizedBox(width: 10),

          // PopupMenuButton<ViewModes>(
          //   icon: const Icon(Icons.view_quilt_outlined),
          //   initialValue: viewMode,
          //   // Callback that sets the selected popup menu item.
          //   onSelected: (ViewModes item) {
          //     setState(() {
          //       viewMode = item;
          //       _showCode = false;
          //       switch (viewMode) {
          //         case ViewModes.auto:
          //           _showHelp = null;
          //           break;
          //         case ViewModes.none:
          //           _showHelp = false;
          //           break;
          //         case ViewModes.help:
          //           _showHelp = true;
          //           break;
          //         case ViewModes.code:
          //           _showHelp = true;
          //           _showCode = true;
          //           break;
          //       }
          //     });
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<ViewModes>>[
          //     const PopupMenuItem<ViewModes>(
          //       value: ViewModes.none,
          //       child: Text('Hide'),
          //     ),
          //     const PopupMenuItem<ViewModes>(
          //       value: ViewModes.help,
          //       child: Text('Help'),
          //     ),
          //     const PopupMenuItem<ViewModes>(
          //       value: ViewModes.code,
          //       child: Text('Code'),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        var showHelp =
            _showHelp != null ? _showHelp == true : constraints.maxWidth > 1000;
        var controller = SplitViewController();

        if (!showHelp) {
          controller.weights = [1, 0];
        } else {
          controller.weights = weight.toList();
        }
        return SplitView(
          viewMode: SplitViewMode.Horizontal,
          indicator: SplitIndicator(
              viewMode: SplitViewMode.Horizontal,
              color: Theme.of(context).dividerColor),
          gripSize: 6,
          gripColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          controller: controller,
          children: [
            SizedBox(child: widget.child),
            SizedBox(
              width: showHelp ? 2 : 0,
              child: showHelp
                  ? Container(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      child: _showCode
                          ? CodeView(
                              code: widget.code,
                              showHelp: () {
                                setState(() {
                                  _showCode = false;
                                  _showHelp = true;
                                });
                              },
                            )
                          : HelpView(
                              help: widget.help,
                              showCode: () {
                                setState(() {
                                  _showCode = true;
                                  _showHelp = true;
                                });
                              },
                            ),
                    )
                  : const SizedBox(width: 5),
            ),
          ],
          onWeightChanged: (w) => setState(() {
            weight = w;
          }),
        );
      }),
    );
  }
}
