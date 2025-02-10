import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_drag_utils/mh_drag_drop_provider.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';
import 'package:mahop_data_table/mh_text/mh_title_medium.dart';

/// More samples you can find in our examples app
/// https://flutterdemo.mahop.net
/// Every sample has also the code attached to be coppied
void main() {
  // Add a [MhDragDropProvider] around all controls supporting a drag drop operation from and to the [MhItemsView]
  // You can skip this, if you don't need drag and drop functionality
  runApp(const MhDragDropProvider(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Table Example',
      home: MyHomePage(title: 'MaHop Flutter Data Table Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // --------------------------------------------
    // - Build some sample data
    // --------------------------------------------
    final List<ExampleItem> items = [];
    for (var i = 1; i <= 100; i++) {
      items.add(ExampleItem(text: "Example Item $i", index: i));
    }

    // --------------------------------------------
    // - Build the Column definitions you need
    // --------------------------------------------
    List<MhItemsViewColumnDef<ExampleItem>> columnDefs = [];

    //Custom widget to be displayed in the cells of a column
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(
        id: "pos",
        header: "Pos",
        columnWidth: 50,
        buildDisplay: (context, item, displayInfo) {
          var isLight = Theme.of(context).brightness == Brightness.light;
          return Container(
              color: displayInfo.rowIsSelected
                  ? isLight
                      ? Colors.red
                      : const Color.fromARGB(255, 78, 5, 0)
                  : item.index % 2 == 0
                      ? isLight
                          ? Colors.yellow
                          : const Color.fromARGB(255, 67, 61, 0)
                      : isLight
                          ? Colors.lightGreen
                          : const Color.fromARGB(255, 34, 63, 0),
              child: Center(child: Text(item.index.toString())));
        }));

    // use the default widget to display values in cells
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(
        id: "index",
        header: "Index",
        columnWidth: 50,
        getDisplayValue: (item) => item.index));
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(
        id: "text",
        header: "Text",
        columnWidth: 250,
        getDisplayValue: (item) => item.text));
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(
        id: "calculated",
        header: "Calculated",
        columnWidth: 250,
        getDisplayValue: (item) => item.index * item.index));

    // --------------------------------------------
    // - apply settings
    // --------------------------------------------
    final settings = MhItemsViewSettings<ExampleItem>(
      rowHeight: 25,
      headerHeight: 30,
      displayHeader: true,
      selectionSettings: MhItemsViewSelectionSettings(
        showSelectColumn: true,
        selectionMode: MhItemsViewSelectionModes.multiple,
      ),
      dragDropSettings: MhItemsViewDragDropSettings(
        allowReorder: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const MhTitleMedium(text: "Some Sample Data"),
          Expanded(
            child: MhItemsView<ExampleItem>(
                itemsSource: items, columnDefs: columnDefs, settings: settings),
          ),
        ],
      ),
    );
  }
}

class ExampleItem {
  String text;
  int index;

  ExampleItem({required this.text, required this.index});

  // This override is needed for better display of item name in drag drop feedback (otherwise "instance of ..." is displayed)
  @override
  String toString() {
    return "Example item $index";
  }
}
