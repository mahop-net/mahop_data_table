import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class MinSampleMioRowsHelp {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MhFormatedText('''
## One Millon Rows / Items
Here you can test performance.

### Things of interest:
- Performance of vertical scrolling
- Accurat scroll handling
- Even with individual row heights

## Be aware:
- In debug mode flutter is pretty slow, especially wthin a Web Browser. Release Builds have a much better performance!
- Right now there is a performance bug in dart for windows creating DateTime instances, so the date col is only displaying strings
        '''),
      ),
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
import 'min_sample_mio_rows_help.dart';

class MinSampleMioRows extends StatefulWidget {
  const MinSampleMioRows({super.key});

  @override
  State<MinSampleMioRows> createState() => _MinSampleMioRowsState();
}

class _MinSampleMioRowsState extends State<MinSampleMioRows> {
  late List<DemoItem> items;
  List<MhItemsViewColumnDef<DemoItem>> columnDefs = [];
  late MhItemsViewSettings<DemoItem> settings;

  @override
  void initState() {
    super.initState();

    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 1000000, multiline: true);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(
        id: "pos",
        header: "Pos",
        columnWidth: 110,
        buildDisplay: (context, item, displayInfo) => Container(
            color: displayInfo.rowIsSelected
                ? Colors.red
                : item.index % 2 == 0
                    ? Colors.yellow
                    : Colors.lightGreen,
            child: Center(child: Text(item.pos)))));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "index", header: "Index", columnWidth: 100, getDisplayValue: (item) => item.index));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text", header: "Text", columnWidth: 250, getDisplayValue: (item) => item.text));
    //columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => DateFormat("yyyy.MM.dd").format(item.date)));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => item.date));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text2", header: "Text 2", columnWidth: 250, getDisplayValue: (item) => "\${item.text} (2)"));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text3", header: "Text 3", columnWidth: 250, getDisplayValue: (item) => "\${item.text} (3)"));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text4", header: "Text 4", columnWidth: 250, getDisplayValue: (item) => "\${item.text} (4)"));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>(getRowHeight: (item) => item.rowHeight ?? 52);
  }

  @override
  Widget build(BuildContext context) {
    //Build the MhItemsView
    var mhItemsView = MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Min-Sample - One Millon Rows",
      code: MinSampleMioRowsHelp.getCode(),
      help: MinSampleMioRowsHelp.buildHelp(),
      child: mhItemsView,
    );
  }
}
    ''';
  }
}
