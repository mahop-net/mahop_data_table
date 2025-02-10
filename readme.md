<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

(Last Update of this info:  9th of Februar 2025

This is the code for this pub.dev widget: https://pub.dev/packages/mahop_data_table



## MaHop DataTable and more - What is included?

- Widget to display a DataTable, ListView with Virtual Scrolling
- With a lot of functionality build in 
  - perfect virtual scrolling even with individual row heights
  - drag and drop reorder
  - drag and drop from and to other widgets
  - sorting and filtering
  - column reorder and resize
  - saving the layout (current column width, positions and visibility) to a JSON string
  - inline edit, multiline edit
  - selection with different selection modes
  - jump to row
  - ...
  - and much more - see demo app and features section below

- Pro Version with extended functionality
  - TreeView, 
  - TreeListView (hierachical DataTable)

## Demos, Sample Code and Pro Version
- See https://flutterdemo.mahop.net
- and https://flutter.mahop.net

Screenshot of the first sample in the demo app
<img src="https://flutter.mahop.net/files/flutter_demo_2.png" />

## Contribute

- Like the project on pub.dev
- Use the code and report bugs
- You can support development buying one or more glasses of orange juice. (or cups of coffee)
  - https://www.buymeacoffee.com/mahop
- Buy a Pro license on https://flutter.mahop.net (from 150,- EURO / year)

## Features

- Perfect virtual scrolling using flutters TwoDimensionalScrollView
  - Display a million and more rows with high performance
  - Display rows with different RowHeights 

- Advanced Drag and Drop
  - Reordering (built in)
  - Multi Drag and Drop (also for reordering)
  - Drag and Drop to and from other Widgets
    - from DataTable to and from another DataTable
    - from DataTable to and from a TreeView
    - from DataTable to a Flutter DropTarget
    - from GridView to and from a ListView
    - ... and so on ...
  - Auto scrolling during drag and drop

- Column resize and reorder on DataTable and TreeListView
  - Saving the current state as JSON string
  - Applying as saved state from JSON string

- JumpTo(item) with height performance

- Selection
  - Single selection
  - CheckBox selection (mutliple items)
  - Extended selection - for Desktop with Mouse click + shift and/or ctrl keys (multiple items)
    - Extended selection can be combined with CheckBox selection

- And more to come in the next versions...

## Usage

```dart
  // ----------------------------------------------
  // - Sample build function - very simple usecase
  // ----------------------------------------------
  Widget buildMhItemsView(BuildContext context) {

    // --------------------------------------------
    // - Build some sample data
    // --------------------------------------------
    final List<ExampleItem> items = [];
    for (var i = 1; i <= 100; i++) {
      items.add(ExampleItem(text: "Example Item $i", index: i));
    }

    // --------------------------------------------
    // - Build the Column definitions you need
    // --------------------------------------------
    List<MhItemsViewColumnDef<ExampleItem>> columnDefs = [];
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(id: "index", header: "Index", columnWidth: 50, getDisplayValue: (item) => item.index));
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(id: "text", header: "Text", columnWidth: 250, getDisplayValue: (item) => item.text));
    columnDefs.add(MhItemsViewColumnDef<ExampleItem>(id: "calculated", header: "Calculated", columnWidth: 250, getDisplayValue: (item) => item.index * item.index));

    // --------------------------------------------
    // - apply needed settings
    // --------------------------------------------
    final settings = MhItemsViewSettings<ExampleItem>(rowHeight: 25, headerHeight: 30, displayHeader: true);

    return MhItemsView<ExampleItem>(itemsSource: items, columnDefs: columnDefs, settings: settings),
  };
```

## Additional information

Go to https://flutter.mahop.net to learn more about the widget and look at the demos with sample code.
