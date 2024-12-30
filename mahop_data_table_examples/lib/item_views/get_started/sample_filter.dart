import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address.dart';
import 'package:mahop_data_table/mh_random_data_generators/addresses/random_address_generator.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view_settings.dart';
import 'package:mahop_data_table/mh_text/mh_body_medium.dart';
import 'package:mahop_data_table_examples/item_views/get_started/sample_filter_help.dart';
import 'package:mahop_data_table_examples/utils/example_view.dart';

class SampleFilter extends StatefulWidget {
  const SampleFilter({super.key});

  @override
  State<SampleFilter> createState() => _SampleFilterState();
}

class _SampleFilterState extends State<SampleFilter> {
  late List<RandomAddress> items;
  List<MhItemsViewColumnDef<RandomAddress>> columnDefs = [];
  late MhItemsViewSettings<RandomAddress> settings;

  @override
  void initState() {
    super.initState();

    //Generate random data to display
    items = RandomAddressGenerator.generateFakeAddressesUs(500);

    //Define the Columns
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "firstName",
        header: "First name",
        columnWidth: 110,
        getDisplayValue: (item) => item.firstName));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "lastName",
        header: "Last name",
        columnWidth: 150,
        getDisplayValue: (item) => item.lastName));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "street",
        header: "Street",
        columnWidth: 150,
        getDisplayValue: (item) => item.street));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "state",
        header: "State",
        columnWidth: 50,
        getDisplayValue: (item) => item.state));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "zipCode",
        header: "Zip",
        columnWidth: 40,
        getDisplayValue: (item) => item.zipCode));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "city",
        header: "City",
        columnWidth: 120,
        getDisplayValue: (item) => item.city));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "telephoneNumber",
        header: "Phone",
        columnWidth: 150,
        getDisplayValue: (item) => item.telephoneNumber));
    columnDefs.add(MhItemsViewColumnDef<RandomAddress>(
        id: "mobileTelephoneNumber",
        header: "Mobile phone",
        columnWidth: 150,
        getDisplayValue: (item) => item.mobileTelephoneNumber));

    // apply some Settings
    settings = MhItemsViewSettings<RandomAddress>(
      rowHeight: 55,
    );
  }

  @override
  Widget build(BuildContext context) {
    // build the table View
    final mhItemsView = MhItemsView<RandomAddress>(
        itemsSource: items, columnDefs: columnDefs, settings: settings);

    //Build the Sample View
    return ExampleView(
      header: "Sample Filter",
      code: SampleFilterHelp.getCode(),
      help: SampleFilterHelp.buildHelp(),
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
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Container(
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
              child: MhBodyMedium(text: "Filter"),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: 150,
                child: TextField(
                  decoration: const InputDecoration(
                      isDense: true, contentPadding: EdgeInsets.all(8)),
                  onChanged: (filterValue) {
                    mhItemsView.setFilter((item) {
                      filterValue = filterValue.toLowerCase();
                      var filterTokens = filterValue.split(" ");
                      for (var filterToken in filterTokens) {
                        var found = false;
                        if (item.firstName
                            .toLowerCase()
                            .contains(filterToken)) {
                          found = true;
                        }
                        if (item.lastName.toLowerCase().contains(filterToken)) {
                          found = true;
                        }
                        if (item.street.toLowerCase().contains(filterToken)) {
                          found = true;
                        }
                        if (item.city.toLowerCase().contains(filterToken)) {
                          found = true;
                        }
                        if (!found) {
                          return false;
                        }
                      }
                      return true;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
