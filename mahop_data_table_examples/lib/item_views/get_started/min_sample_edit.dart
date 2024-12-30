import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';
import 'min_sample_edit_help.dart';

class MinSampleEdit extends StatefulWidget {
  const MinSampleEdit({super.key});

  @override
  State<MinSampleEdit> createState() => _MinSampleEditState();
}

class _MinSampleEditState extends State<MinSampleEdit> {
  late List<DemoItem> items;
  List<MhItemsViewColumnDef<DemoItem>> columnDefs = [];
  late MhItemsViewSettings<DemoItem> settings;

  @override
  void initState() {
    super.initState();

    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 100);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "index",
        header: "Index",
        columnWidth: 50,
        getDisplayValue: (item) => item.index,
        getEditValue: (item) => item.index,
        setEditValue: (item, value) =>
            item.index = int.parse(value?.toString() ?? "0")));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "text",
        header: "Text",
        columnWidth: 250,
        getDisplayValue: (item) => item.text,
        getEditValue: (item) => item.text,
        setEditValue: (item, value) => item.text = value?.toString() ?? ""));
    //columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => DateFormat("yyyy.MM.dd").format(item.date), getEditValue: (item) => item.date));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "date",
        header: "Date",
        columnWidth: 100,
        getDisplayValue: (item) => item.date));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>(
      rowHeight: 65,
    );
    settings.selectionSettings.selectionMode =
        MhItemsViewSelectionModes.multiple;
    settings.selectionSettings.showSelectColumn = true;
  }

  @override
  Widget build(BuildContext context) {
    //Build the MhItemsView
    var mhItemsView = MhItemsView<DemoItem>(
        itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Min-Sample DataTable",
      code: MinSampleEditHelp.getCode(),
      help: MinSampleEditHelp.buildHelp(),
      child: mhItemsView,
    );
  }
}
