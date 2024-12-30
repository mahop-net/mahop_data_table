import 'package:flutter/material.dart';
import 'package:mahop_data_table/main.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';
import 'min_sample_data_table_view_help.dart';

class MinSampleDataTableView extends StatefulWidget {
  const MinSampleDataTableView({super.key});

  @override
  State<MinSampleDataTableView> createState() => _MinSampleDataTableViewState();
}

class _MinSampleDataTableViewState extends State<MinSampleDataTableView> {
  late List<DemoItem> items;
  List<MhItemsViewColumnDef<DemoItem>> columnDefs = [];
  MhItemsViewSettings<DemoItem> settings = MhItemsViewSettings<DemoItem>();

  @override
  void initState() {
    super.initState();

    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 100);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "pos",
        header: "Pos",
        columnWidth: 50,
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
    settings.selectionSettings.showHoverBackground = true;
  }

  @override
  Widget build(BuildContext context) {
    //Build the MhItemsView
    var mhItemsView = MhItemsView<DemoItem>(
        itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Min-Sample DataTable",
      code: MinSampleDataTableViewHelp.getCode(),
      help: MinSampleDataTableViewHelp.buildHelp(),
      child: mhItemsView,
    );
  }
}
