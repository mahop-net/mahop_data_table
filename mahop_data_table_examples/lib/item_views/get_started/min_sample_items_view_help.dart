import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class MinSampleItemsViewHelp {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(8.0), child: MhFormatedText('''
## Min Sample Items View
This is a DataTable with just one Column and Header is not displayed.
This is like a normal Flutter ListView, with the advantage of auto virtualisation.

### Things of interest:
- Single Column without header
- Column expanded in width to use the whole area
        ''')),
    );
  }

  static String getCode() {
    return '''
import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';
import 'min_sample_items_view_help.dart';

class MinSampleItemsView extends StatefulWidget {
  const MinSampleItemsView({super.key});

  @override
  State<MinSampleItemsView> createState() => _MinSampleItemsViewState();
}

class _MinSampleItemsViewState extends State<MinSampleItemsView> {
  late List<DemoItem> items;
  List<MhItemsViewColumnDef<DemoItem>> columnDefs = [];
  late MhItemsViewSettings<DemoItem> settings;

  @override
  void initState() {
    super.initState();
    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 10000, multiline: true);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text", header: "Text", getDisplayValue: (item) => item.text));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>(displayHeader: false, getRowHeight: (item) => item.rowHeight ?? 52);
  }

  @override
  Widget build(BuildContext context) {
    // Build the ItemsView (DataTable with one expanding column)
    var mhItemsView = MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Min-Sample ItemsView",
      code: MinSampleItemsViewHelp.getCode(),
      help: MinSampleItemsViewHelp.buildHelp(),
      child: mhItemsView,
    );
  }
}
    ''';
  }
}
