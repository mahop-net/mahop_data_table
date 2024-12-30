import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_formated_text.dart';

class SampleInvitationsHelp {
  static Widget buildHelp() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: MhFormatedText('''
## Invitations Overview
This is a DataTable of random sample address data.
With a MhStatusBar on the right side.

### Things of interest:
- You can scroll the DataTable horizontally and vertically
- You can resize and reorder the columns,
- You can sort the data via the sort icon of each column,
- Sorting can be done by multiple columns holding use the shift key,
- The status column is editable
- The status column is a custom column type displaying a custom Widget
- You can see open items in the MhStatusBar
- You can hover on the items in the MhStatusBar to see the name (=custom value)
- You tab or click on items in the MhStatus Bar to jump to the item in the list
- With the settings icon in the MhStatusBar you can control what status levels you want to see
        '''),
      ),
    );
  }

  static String getCode() {
    return '''
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address_generator.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';
import 'package:mahop_data_table/mh_overlays/mh_popup.dart';
import 'package:mahop_data_table/mh_status_view/mh_status_view_settings.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_invitations_help.dart';
import 'package:mahop_data_table_examples/utils/example_view.dart';

class SampleInvitations extends StatefulWidget {
  const SampleInvitations({super.key});

  @override
  State<SampleInvitations> createState() => _SampleInvitationsState();
}

class _SampleInvitationsState extends State<SampleInvitations> {
  late List<InvitationStatusItemViewModel> items;
  List<MhItemsViewColumnDef<InvitationStatusItemViewModel>> columnDefs = [];
  late MhItemsViewSettings<InvitationStatusItemViewModel> settings;

  @override
  void initState() {
    super.initState();

    //Generate random data to display
    var rnd = Random();
    var addresses = RandomAddressGenerator.generateFakeAddressesUs(500);
    items = addresses.map((i) {
      var status = rnd.nextInt(81);
      InvitationStatus invitationsStatus;
      switch (status) {
        case < 20:
          invitationsStatus = InvitationStatus.invitationSend;
          break;
        case < 70:
          invitationsStatus = InvitationStatus.accepted;
          break;
        case < 79:
          invitationsStatus = InvitationStatus.declined;
          break;
        default:
          invitationsStatus = InvitationStatus.addressWrong;
          break;
      }
      return InvitationStatusItemViewModel(address: i, invitationsStatus: invitationsStatus);
    }).toList();

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(
      id: "status",
      header: "Invitation status",
      columnWidth: 180,
      buildDisplay: (BuildContext context, InvitationStatusItemViewModel item, MhItemsViewDisplayInfo displayInfo) => buildInvitationStatus(context, item, displayInfo),
      allowSorting: true,
      getSortValue: (item) => item.invitationsStatus,
    ));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "firstName", header: "First name", columnWidth: 110, getDisplayValue: (item) => item.address.firstName, allowSorting: true));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "lastName", header: "Last name", columnWidth: 150, getDisplayValue: (item) => item.address.lastName, allowSorting: true));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "street", header: "Street", columnWidth: 150, getDisplayValue: (item) => item.address.street));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "state", header: "State", columnWidth: 50, getDisplayValue: (item) => item.address.state, allowSorting: true));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "zipCode", header: "Zip", columnWidth: 40, getDisplayValue: (item) => item.address.zipCode, allowSorting: true));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "city", header: "City", columnWidth: 120, getDisplayValue: (item) => item.address.city, allowSorting: true));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "telephoneNumber", header: "Phone", columnWidth: 150, getDisplayValue: (item) => item.address.telephoneNumber));
    columnDefs.add(MhItemsViewColumnDef<InvitationStatusItemViewModel>(id: "mobileTelephoneNumber", header: "Mobile phone", columnWidth: 150, getDisplayValue: (item) => item.address.mobileTelephoneNumber));

    // apply some Settings
    settings = MhItemsViewSettings<InvitationStatusItemViewModel>(
      rowHeight: 55,
    );

    // apply settings for the StatusView
    settings.statusViewSettings = MhStatusViewSettings<InvitationStatusItemViewModel>(itemsDef: [
      MhStatusViewItemsDef<InvitationStatusItemViewModel>(text: "Invitations send", color: Colors.blue, showItem: (item) => item.invitationsStatus == InvitationStatus.invitationSend, displayItems: false, tooltipText: (item) => "\${item.address.firstName} \${item.address.lastName}"),
      MhStatusViewItemsDef<InvitationStatusItemViewModel>(text: "Invitations accepted", color: Colors.green, showItem: (item) => item.invitationsStatus == InvitationStatus.accepted, displayItems: false, tooltipText: (item) => "\${item.address.firstName} \${item.address.lastName}"),
      MhStatusViewItemsDef<InvitationStatusItemViewModel>(text: "Invitations declined", color: const Color.fromARGB(255, 255, 196, 0), showItem: (item) => item.invitationsStatus == InvitationStatus.declined, tooltipText: (item) => "\${item.address.firstName} \${item.address.lastName}"),
      MhStatusViewItemsDef<InvitationStatusItemViewModel>(text: "Wrong address", color: Colors.red, showItem: (item) => item.invitationsStatus == InvitationStatus.addressWrong, tooltipText: (item) => "\${item.address.firstName} \${item.address.lastName}"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // build the table View
    var mhItemsView = MhItemsView<InvitationStatusItemViewModel>(itemsSource: items, columnDefs: columnDefs, settings: settings);

    //Build the Sample View
    return ExampleView(
      header: "Sample Invitation Overview",
      code: SampleInvitationsHelp.getCode(),
      help: SampleInvitationsHelp.buildHelp(),
      child: mhItemsView,
    );
  }

  Widget buildInvitationStatus(BuildContext context, InvitationStatusItemViewModel item, MhItemsViewDisplayInfo rowIsSelected) {
    //todo Build a nice looking widget for the status
    var popupController = OverlayPortalController();

    return Align(
      alignment: Alignment.centerLeft,
      child: MhPopup(
        controller: popupController,
        popupWidth: 200,
        popupHeight: 300,
        targetAnchor: Alignment.bottomLeft,
        followerAnchor: Alignment.topLeft,
        follower: buildPopup(context, item, popupController),
        child: buildInvitationStatusLabel(item.invitationsStatus, true),
      ),
    );
  }

  Widget buildInvitationStatusLabel(InvitationStatus status, bool withArrow) {
    var color = Colors.transparent;
    var textColor = Colors.black;
    var text = "";
    switch (status) {
      case InvitationStatus.invitationSend:
        text = "Invitation send";
        color = Colors.blue;
        textColor = Colors.white;
        break;
      case InvitationStatus.accepted:
        text = "accepted";
        color = Colors.green;
        textColor = Colors.black;
        break;
      case InvitationStatus.declined:
        text = "declined";
        color = Colors.yellow;
        textColor = Colors.black;
        break;
      case InvitationStatus.addressWrong:
        text = "Address wrong";
        color = Colors.red;
        textColor = Colors.white;
        break;
      default:
        text = " - ";
    }

    List<Widget> children = [];
    children.add(Text(text, style: TextStyle(color: textColor)));
    if (withArrow) {
      children.add(const SizedBox(width: 2));
      children.add(Icon(Icons.arrow_drop_down, color: textColor));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget buildPopup(BuildContext context, InvitationStatusItemViewModel item, OverlayPortalController popupController) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(40, 125, 125, 125), width: 2), color: Theme.of(context).dialogBackgroundColor),
      width: 200,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Select new invitation status:"),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item.invitationsStatus = InvitationStatus.invitationSend;
                  popupController.hide();
                });
              },
              child: buildInvitationStatusLabel(InvitationStatus.invitationSend, false),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item.invitationsStatus = InvitationStatus.accepted;
                  popupController.hide();
                });
              },
              child: buildInvitationStatusLabel(InvitationStatus.accepted, false),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item.invitationsStatus = InvitationStatus.declined;
                  popupController.hide();
                });
              },
              child: buildInvitationStatusLabel(InvitationStatus.declined, false),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  item.invitationsStatus = InvitationStatus.addressWrong;
                  popupController.hide();
                });
              },
              child: buildInvitationStatusLabel(InvitationStatus.addressWrong, false),
            ),
          ),
        ],
      ),
    );
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
