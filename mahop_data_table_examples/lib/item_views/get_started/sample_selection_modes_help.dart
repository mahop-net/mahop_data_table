import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class SampleSelectionModesHelp {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MhFormatedText('''
## Sample selection modes
This sample shows the different selections modes MhItemsView provides

### Things of interest:
- Switch the different selection modes and have fun :-)
- On Platforms with mouse and keyboard you can use the SHIFT and CTRL keys together with klicks

### Be aware:
Right now there is a performance bug in dart for windows creating DateTime instances, so the date col is only displaying strings
        '''),
      ),
    );
  }

  static String getCode() {
    return '''
import 'package:flutter/material.dart';
import 'package:mahop_data_table/main.dart';

import '../../utils/example_view.dart';
import '../demo-data/demo_item.dart';
import '../demo-data/demo_item_generator.dart';
import 'sample_selection_modes_help.dart';

class SampleSelectionModes extends StatefulWidget {
  const SampleSelectionModes({super.key});

  @override
  State<SampleSelectionModes> createState() => _SampleSelectionModesState();
}

class _SampleSelectionModesState extends State<SampleSelectionModes> {
  late List<DemoItem> items;
  late List<MhItemsViewColumnDef<DemoItem>> columnDefs;
  late MhItemsViewSettings<DemoItem> settings;

  @override
  void initState() {
    super.initState();

    //Get the Data to display
    items = DemoItemGenerator().generateItems(count: 100);

    //Define the Columns
    columnDefs = [];
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "index", header: "Index", columnWidth: 50, getDisplayValue: (item) => item.index));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "text", header: "Text", columnWidth: 250, getDisplayValue: (item) => item.text));
    //columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => DateFormat("yyyy.MM.dd").format(item.date)));
    columnDefs.add(MhItemsViewColumnDef<DemoItem>(id: "date", header: "Date", columnWidth: 100, getDisplayValue: (item) => item.date));

    // apply some Settings
    settings = MhItemsViewSettings<DemoItem>();
    settings.selectionSettings.selectionMode = MhItemsViewSelectionModes.multiple;
    settings.selectionSettings.selectionType = MhItemsViewSelectionTypes.fullRow;
    settings.selectionSettings.showSelectColumn = true;
  }

  @override
  Widget build(BuildContext context) {
    //Create the mhItemsView
    var mhItemsView = MhItemsView<DemoItem>(itemsSource: items, columnDefs: columnDefs, settings: settings);

    return ExampleView(
      header: "Sample selection modes",
      code: SampleSelectionModesHelp.getCode(),
      help: SampleSelectionModesHelp.buildHelp(),
      child: Column(
        children: [
          buildSampleToolBar(),
          Expanded(child: mhItemsView),
        ],
      ),
    );
  }

  Widget buildSampleToolBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest, width: 2),
          top: BorderSide(color: Theme.of(context).colorScheme.surfaceContainerHighest, width: 2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(16.0), child: Text("Selection Mode:")),
          SegmentedButton<MhItemsViewSelectionModes>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<MhItemsViewSelectionModes>>[
              ButtonSegment<MhItemsViewSelectionModes>(value: MhItemsViewSelectionModes.none, label: Text('None')),
              ButtonSegment<MhItemsViewSelectionModes>(value: MhItemsViewSelectionModes.single, label: Text('Single')),
              ButtonSegment<MhItemsViewSelectionModes>(value: MhItemsViewSelectionModes.multiple, label: Text('Multiple')),
            ],
            selected: <MhItemsViewSelectionModes>{settings.selectionSettings.selectionMode},
            onSelectionChanged: (Set<MhItemsViewSelectionModes> newSelection) {
              setState(() {
                settings.selectionSettings.selectionMode = newSelection.first;
                if (settings.selectionSettings.selectionMode == MhItemsViewSelectionModes.none) {
                  settings.selectionSettings.showSelectColumn = false;
                } else {
                  settings.selectionSettings.showSelectColumn = true;
                }
              });
            },
          ),
          const Padding(padding: EdgeInsets.all(16.0), child: Text("Selection Type:")),
          SegmentedButton<MhItemsViewSelectionTypes>(
            showSelectedIcon: false,
            segments: const <ButtonSegment<MhItemsViewSelectionTypes>>[
              ButtonSegment<MhItemsViewSelectionTypes>(value: MhItemsViewSelectionTypes.fullRow, label: Text('Full Row')),
              ButtonSegment<MhItemsViewSelectionTypes>(value: MhItemsViewSelectionTypes.selectionColumnOnly, label: Text('Selection column')),
            ],
            selected: <MhItemsViewSelectionTypes>{settings.selectionSettings.selectionType},
            onSelectionChanged: (Set<MhItemsViewSelectionTypes> newSelection) {
              setState(() {
                settings.selectionSettings.selectionType = newSelection.first;
              });
            },
          ),
          // TextButton(onPressed: () => settings.selectionSettings.selectionType = MhTimesViewSelectionTypes.fullRow, child: const Text("Full row")),
          // TextButton(onPressed: () => settings.selectionSettings.selectionType = MhTimesViewSelectionTypes.selectionColumnOnly, child: const Text("Selection column only")),
        ],
      ),
    );
  }
}
    ''';
  }
}
