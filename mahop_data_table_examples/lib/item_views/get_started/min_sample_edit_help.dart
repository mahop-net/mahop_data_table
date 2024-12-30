import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class MinSampleEditHelp {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MhFormatedText('''
## Min Sample Inline Edit
Here you can test editing the second and third column.

### Things of interest:
- Multi Select with Check Box
- Extended Multi Select with Keyboard support (shift and CTRL)

- Inline editing
- Multi row editing - just select more items and edit one of them and leave the cell

### Keyboard support:
- Tab Key moves right - shift Tab left
- Enter Key moves down - shift Enter up
- First and last Columns can not be edited

### Be aware:
Right now there is a performance bug in dart for windows creating DateTime instances, so the date col is only displaying strings
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
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "index", header: "Index", columnWidth: 50, getDisplayValue: (item) => item.index, getEditValue: (item) => item.index, setEditValue: (item, value) => item.index = int.parse(value?.toString() ?? "0")));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text", header: "Text", columnWidth: 250, getDisplayValue: (item) => item.text, getEditValue: (item) => item.text, setEditValue: (item, value) => item.text = value?.toString() ?? ""));
    //columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => DateFormat("yyyy.MM.dd").format(item.date), getEditValue: (item) => item.date));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => item.date));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>(
      rowHeight: 65,
    );
    settings.selectionSettings.selectionMode = MhItemsViewSelectionModes.multiple;
    settings.selectionSettings.showSelectColumn = true;
  }

  @override
  Widget build(BuildContext context) {
    //Build the MhItemsView
    var mhItemsView = MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Min-Sample DataTable",
      code: MinSampleEditHelp.getCode(),
      help: MinSampleEditHelp.buildHelp(),
      child: mhItemsView,
    );
  }
}
    ''';
  }
}
