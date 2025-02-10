import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_jump_to_help.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';

class SampleJumpTo extends StatefulWidget {
  const SampleJumpTo({super.key});

  @override
  State<SampleJumpTo> createState() => _SampleJumpToState();
}

class _SampleJumpToState extends State<SampleJumpTo> {
  late List<DemoItem> items;
  List<MhItemsViewColumnDef<DemoItem>> columnDefs = [];

  @override
  void initState() {
    super.initState();

    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 1000);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "pos",
        header: "Pos",
        columnWidth: 80,
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
              child: Center(child: Text(item.pos)));
        }));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "index",
        header: "Index",
        columnWidth: 50,
        getDisplayValue: (item) => item.index));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "text",
        header: "Text",
        columnWidth: 250,
        getDisplayValue: (item) => item.text));
    //columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => DateFormat("yyyy.MM.dd").format(item.date)));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "date",
        header: "Date",
        columnWidth: 100,
        getDisplayValue: (item) => item.date));
  }

  @override
  Widget build(BuildContext context) {
    var mhItemsView =
        MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs);
    return ExampleView(
      header: "Sample Jump to",
      code: SampleJumpToHelp.getCode(),
      help: SampleJumpToHelp.buildHelp(),
      child: Column(
        children: [
          buildSampleToolBar(mhItemsView),
          Expanded(child: mhItemsView),
        ],
      ),
    );
  }

  Widget buildSampleToolBar(MhItemsView mhItemsView) {
    //Pick some items to jump to
    var firstItem = items[0];
    var lastItem = items[items.length - 1];
    var item50 = items[49];
    var item550 = items[549];
    var item950 = items[949];

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: 2),
          top: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: 2),
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Jump to:"),
          ),
          TextButton(
              onPressed: () => mhItemsView.jumpTo(item: firstItem),
              child: const Text("First item")),
          TextButton(
              onPressed: () => mhItemsView.jumpTo(item: lastItem),
              child: const Text("Last item")),
          TextButton(
              onPressed: () => mhItemsView.jumpTo(item: item50),
              child: const Text("Item 50")),
          TextButton(
              onPressed: () => mhItemsView.jumpTo(item: item550),
              child: const Text("Item 550")),
          TextButton(
              onPressed: () => mhItemsView.jumpTo(item: item950),
              child: const Text("Item 950")),
        ],
      ),
    );
  }
}
