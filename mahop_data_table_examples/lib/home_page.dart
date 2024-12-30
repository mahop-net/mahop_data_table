import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mahop_data_table/mh_text/mh_body_medium.dart';
import 'package:mahop_data_table/mh_text/mh_bullet_list.dart';
import 'package:mahop_data_table/mh_text/mh_headline_large.dart';
import 'package:mahop_data_table/mh_text/mh_headline_small.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    _themeMode = MainApp.of(context).themeMode;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
                height: 60, child: DrawerHeader(child: Text('Intros'))),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-invitations-view'),
                      child: const Text('Invitation overview'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/min-sample-mio-rows'),
                      child: const Text('1 million rows'))
                ])),
            const SizedBox(
                height: 60,
                child: DrawerHeader(child: Text('Getting started'))),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/min-sample-items-view'),
                      child: const Text('Min sample ItemsView'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () =>
                          context.go('/min-sample-data-table-view'),
                      child: const Text('Min sample DataTable View'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/min-sample-edit'),
                      child: const Text('Min sample edit'))
                ])),
            const SizedBox(
                height: 60,
                child: DrawerHeader(child: Text('Feature Samples'))),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-reorder-rows'),
                      child: const Text('Reorder with auto scroll'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-drag-drop-1'),
                      child: const Text('Drag Drop between lists'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-jump-to'),
                      child: const Text('Jump to Item'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-save-view-state'),
                      child: const Text('Save and apply view state'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/min-sample-edit'),
                      child: const Text('Inline (multiline) Edit'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-selection-modes'),
                      child: const Text('Selection modes'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/sample-filter'),
                      child: const Text('Filter'))
                ])),

            const SizedBox(
                height: 60, child: DrawerHeader(child: Text('Flutter Tests'))),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/scroll-test'),
                      child: const Text('Scroll Test'))
                ])),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () => context.go('/scroll-test2'),
                      child: const Text('Scroll Test 2'))
                ])),

            //Padding(padding: const EdgeInsets.only(left: 20), child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [TextButton(onPressed: () => context.go('/todo-view'), child: const Text('Drag Drop to 2. list'))])),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: const Text('MaHop.Net - Data Widgets - Examples'),
        actions: [
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
        ],
      ),
      body: buildHomepage(context),
    );
  }

  Widget buildHomepage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.grey, width: 1, style: BorderStyle.solid))),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MhHeadlineSmall(
                      text:
                          "Please be aware: All sample data is generated randomly!",
                      textColor: Colors.orange),
                  SizedBox(height: 10),
                  MhHeadlineLarge(
                      text: "Wellcome to Flutter MaHop.Net DataViews"),
                  SizedBox(height: 10),
                  MhBodyMedium(
                      text:
                          "Collection of Flutter Widgets to display a DataTable, TreeView, TreeListView, ListView and GridView with many options, editing, advanced drag and drop support and much more.",
                      overflow: TextOverflow.visible,
                      bottomPadding: 5),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MhBodyMedium(
                                text: "It can display:",
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.bold),
                            MhBulletList([
                              "ItemsView",
                              "DataTable",
                              "TreeView (Pro)",
                              "TreeListView or hierachical DataTable (Pro)",
                              "GridView (planned)",
                            ]),
                            SizedBox(height: 20),
                            MhBodyMedium(
                                text: "It offers:",
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.bold),
                            MhBulletList([
                              "horizontal and vertical scrolling",
                              "perfect virtualisation - even with individual rowheight per item",
                              "jump to item or index",
                              "inline edit and multirow edit",
                              "reorder per drag and drop",
                              "drag and drop from and to other Widgets",
                              "filtering",
                              "column resize and reorder per drag and drop",
                              "save and apply layout from and to JSON string",
                              "and much more...",
                            ]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image(
                            width: 400,
                            height: 400,
                            fit: BoxFit.contain,
                            image: AssetImage('images/home01.png')),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MhBodyMedium(
                      text:
                          "Open the menu in the title bar to navigate to the demos with sample code.",
                      overflow: TextOverflow.visible,
                      bottomPadding: 5,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
