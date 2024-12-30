import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';
import 'sample_reorder_rows_help.dart';

class SampleReorderRows extends StatefulWidget {
  const SampleReorderRows({super.key});

  @override
  State<SampleReorderRows> createState() => _SampleReorderRowsState();
}

class _SampleReorderRowsState extends State<SampleReorderRows> {
  late List<DemoItem> items;
  late MhItemsViewSettings<DemoItem> settings;
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
        getDisplayValue: (item) => item.pos));
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
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "date",
        header: "Date",
        columnWidth: 100,
        getDisplayValue: (item) => item.date));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>(
      selectionSettings: MhItemsViewSelectionSettings(
        selectionMode: MhItemsViewSelectionModes.multiple,
        selectionType: MhItemsViewSelectionTypes.fullRow,
        showSelectColumn: true,
      ),
      dragDropSettings: MhItemsViewDragDropSettings<DemoItem>(
        allowDrag: true,
        allowDrop: true,
        allowReorder: true,
        showReorderColumn: true,
        dragDropMode: MhItemsViewDragDropModes.reorderColumnOnly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mhItemsView = MhItemsView<DemoItem>(
        itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Sample reorder rows",
      code: SampleReorderRowsHelp.getCode(),
      help: SampleReorderRowsHelp.buildHelp(),
      child: Column(
        children: [
          buildExampleToolbar(),
          Expanded(child: mhItemsView),
        ],
      ),
    );
  }

  Row buildExampleToolbar() {
    return Row(
      children: [
        const Padding(
            padding: EdgeInsets.all(16.0), child: Text("DragDrop Mode:")),
        SegmentedButton<MhItemsViewDragDropModes>(
          showSelectedIcon: false,
          segments: const <ButtonSegment<MhItemsViewDragDropModes>>[
            ButtonSegment<MhItemsViewDragDropModes>(
                value: MhItemsViewDragDropModes.fullRow,
                label: Text('Full Row')),
            ButtonSegment<MhItemsViewDragDropModes>(
                value: MhItemsViewDragDropModes.reorderColumnOnly,
                label: Text('DragDrop Icon Only')),
          ],
          selected: <MhItemsViewDragDropModes>{
            settings.dragDropSettings.dragDropMode
          },
          onSelectionChanged: (Set<MhItemsViewDragDropModes> newSelection) {
            setState(() {
              settings.dragDropSettings.dragDropMode = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}
