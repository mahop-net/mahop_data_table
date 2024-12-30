import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class SampleDragDrop1Help {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MhFormatedText('''
## Drag and drop between data tables
This are two data tables of random sample address data.

### Things of interest:
- You can drag and drop items from one table to the other
- On the left table you can select multiple items and drag them together to the right table 
- Default is, to move the items from one table to the other
- You can use STRG to copy the items to the other table
- In both tables you can also reorder the items

### Important:
- You have to wrap your complete app or at least the area where you want the drag and drop to work with a MhDragDropProvider
        '''),
      ),
    );
  }

  static String getCode() {
    return '''

import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_drag_utils/mh_accept_drop_result.dart';
import 'package:mahop_data_table/mh_drag_utils/mh_drag_state.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address_generator.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';
import 'package:mahop_data_table_examples/utils/example_view.dart';

import 'sample_drag_drop_1_help.dart';

class SampleDragDrop1 extends StatefulWidget {
  const SampleDragDrop1({super.key});

  @override
  State<SampleDragDrop1> createState() => _SampleDragDrop1State();
}

class _SampleDragDrop1State extends State<SampleDragDrop1> {
  late List<RandomAddress> items1;
  late List<RandomAddress> items2;

  late List<MhItemsViewColumnDef<RandomAddress>> columnDefs2 = [];
  late List<MhItemsViewColumnDef<RandomAddress>> columnDefs1 = [];

  late MhItemsViewSettings<RandomAddress> settings1 = MhItemsViewSettings<RandomAddress>(rowHeight: 35);
  late MhItemsViewSettings<RandomAddress> settings2 = MhItemsViewSettings<RandomAddress>(rowHeight: 35);

  @override
  void initState() {
    super.initState();

    //Generate random data to display
    items1 = RandomAddressGenerator.generateFakeAddressesUs(100);
    //items2 = FakeAddressGenerator.generateFakeAddressesUs(10);
    items2 = List<RandomAddress>.empty(growable: true);

    //Define the Columns
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "firstName", header: "First name", columnWidth: 110, getDisplayValue: (item) => item.firstName));
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "lastName", header: "Last name", columnWidth: 150, getDisplayValue: (item) => item.lastName));
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "street", header: "Street", columnWidth: 150, getDisplayValue: (item) => item.street));
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "state", header: "State", columnWidth: 50, getDisplayValue: (item) => item.state));
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "zipCode", header: "Zip", columnWidth: 40, getDisplayValue: (item) => item.zipCode));
    columnDefs1.add(MhItemsViewColumnDef<RandomAddress>(id: "city", header: "City", columnWidth: 120, getDisplayValue: (item) => item.city));

    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "firstName", header: "First name", columnWidth: 110, getDisplayValue: (item) => item.firstName));
    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "lastName", header: "Last name", columnWidth: 150, getDisplayValue: (item) => item.lastName));
    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "street", header: "Street", columnWidth: 150, getDisplayValue: (item) => item.street));
    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "state", header: "State", columnWidth: 50, getDisplayValue: (item) => item.state));
    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "zipCode", header: "Zip", columnWidth: 40, getDisplayValue: (item) => item.zipCode));
    columnDefs2.add(MhItemsViewColumnDef<RandomAddress>(id: "city", header: "City", columnWidth: 120, getDisplayValue: (item) => item.city));

    // apply some Settings
    //settings1 = MhItemsViewSettings<RandomAddress>(rowHeight: 35);
    settings1.selectionSettings.selectionMode = MhItemsViewSelectionModes.multiple;
    settings1.selectionSettings.showSelectColumn = true;
    settings1.dragDropSettings.allowDrag = true;
    settings1.dragDropSettings.allowDrop = true;
    settings1.dragDropSettings.allowReorder = true;
    settings1.dragDropSettings.onAcceptDrop = _dropAccepted1;

    //settings2 = MhItemsViewSettings<RandomAddress>(rowHeight: 35);
    settings2.selectionSettings.selectionMode = MhItemsViewSelectionModes.multiple;
    settings2.selectionSettings.showSelectColumn = true;
    settings2.dragDropSettings.allowDrag = true;
    settings2.dragDropSettings.allowDrop = true;
    settings2.dragDropSettings.allowReorder = true;
    settings2.dragDropSettings.onAcceptDrop = _dropAccepted2;
    settings2.textSettings.noDataToDisplay = "Drag items here...";
  }

  @override
  Widget build(BuildContext context) {
    // build the table View
    final tableView1 = MhItemsView<RandomAddress>(itemsSource: items1, columnDefs: columnDefs1, settings: settings1);
    final tableView2 = MhItemsView<RandomAddress>(itemsSource: items2, columnDefs: columnDefs2, settings: settings2);

    //Build the SampleView
    return ExampleView(
      header: "Sample Drag And Drop between DataTables",
      code: SampleDragDrop1Help.getCode(),
      help: SampleDragDrop1Help.buildHelp(),
      child: Row(
        children: [
          Expanded(child: tableView1),
          Container(width: 2, color: Colors.grey),
          Expanded(child: tableView2),
        ],
      ),
    );
  }

  MhAcceptDropResult _dropAccepted1(MhDragState dragState, List<RandomAddress> droppedItems, RandomAddress? targetItem) {
    setState(() {
      // if (targetItem == null) {
      //   //Drop in an empty List or below the last item
      //   items1.addAll(droppedItems);
      // } else {
      //   //Insert the droppedItems at the right place
      //   var index = items1.indexOf(targetItem);
      //   if (dragState.dropPosition == null || dragState.dropPosition == MhDropPosition.below) {
      //     index++;
      //   }
      //   for (var droppedItem in droppedItems) {
      //     items1.insert(index, droppedItem);
      //   }
      // }
    });

    //Return true to show the drop was successful
    return MhAcceptDropResult();
  }

  MhAcceptDropResult _dropAccepted2(MhDragState dragState, List<RandomAddress> droppedItems, RandomAddress? targetItem) {
    setState(() {
      // if (targetItem == null) {
      //   //Drop in an empty List or below the last item
      //   items2.addAll(droppedItems);
      // } else {
      //   //Insert the droppedItems at the right place
      //   var index = items2.indexOf(targetItem);
      //   if (dragState.dropPosition == null || dragState.dropPosition == MhDropPosition.below) {
      //     index++;
      //   }
      //   for (var droppedItem in droppedItems) {
      //     items2.insert(index, droppedItem);
      //     index++;
      //   }
      // }
    });

    //Return true to show the drop was successful
    return MhAcceptDropResult();
  }
}

enum InvitationStatus { noAction, invitationSend, accepted, declined, addressWrong }

class InvitationStatusItemViewModel {
  RandomAddress address;
  InvitationStatus invitationsStatus;

  InvitationStatusItemViewModel({required this.address, required this.invitationsStatus});
  @override
  String toString() {
    return "\${address.firstName} \${address.lastName}";
  }
}

''';
  }
}
