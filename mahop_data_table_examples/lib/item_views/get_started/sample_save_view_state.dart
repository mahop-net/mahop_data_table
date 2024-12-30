import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_save_view_state_help.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';

class SampleSaveViewState extends StatefulWidget {
  const SampleSaveViewState({super.key});

  @override
  State<SampleSaveViewState> createState() => _SampleSaveViewStateState();
}

class _SampleSaveViewStateState extends State<SampleSaveViewState> {
  String _viewState = "";
  final String _viewState1 =
      '[{"id":"index","columnWidth":69.19999999999993},{"id":"pos","columnWidth":64.80000000000005},{"id":"text","columnWidth":406.0000000000022},{"id":"date","columnWidth":100.0}]';
  final String _viewState2 =
      '[{"id":"index","columnWidth":92.39999999999985},{"id":"date","columnWidth":93.60000000000002},{"id":"text","columnWidth":406.0000000000022},{"id":"pos","columnWidth":189.60000000000068}]';

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
        buildDisplay: (context, item, displayInfo) => Container(
            color: displayInfo.rowIsSelected
                ? Colors.red
                : item.index % 2 == 0
                    ? Colors.yellow
                    : Colors.lightGreen,
            child: Center(child: Text(item.pos)))));
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

    // apply some Settings
    //var settings = MhItemsViewSettings<DemoItem>(...);
  }

  @override
  Widget build(BuildContext context) {
    var mhItemsView =
        MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs);
    return ExampleView(
      header: "Sample Jump to",
      code: SampleSaveViewStateHelp.getCode(),
      help: SampleSaveViewStateHelp.buildHelp(),
      child: Column(
        children: [
          buildSampleToolBar(mhItemsView),
          Expanded(child: mhItemsView),
        ],
      ),
    );
  }

  Widget buildSampleToolBar(MhItemsView mhItemsView) {
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
              onPressed: () => _viewState = mhItemsView.getColumnLayoutJson(),
              child: const Text("Save current state")),
          TextButton(
              onPressed: () {
                if (_viewState == "") {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Saved state required'),
                      content: const Text('Please save a state first'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  mhItemsView.setColumnLayoutFromJson(jsonStr: _viewState);
                }
              },
              child: const Text("Apply saved state")),
          TextButton(
              onPressed: () =>
                  mhItemsView.setColumnLayoutFromJson(jsonStr: _viewState1),
              child: const Text("Apply state 1")),
          TextButton(
              onPressed: () =>
                  mhItemsView.setColumnLayoutFromJson(jsonStr: _viewState2),
              child: const Text("Apply state 2")),
        ],
      ),
    );
  }
}
