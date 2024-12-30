part of '../mh_items_view.dart';

enum MhItemsViewMoveFocusDirections { up, down, left, right }

/// This class is an internal class for MhItemsView holding the current Widget State
class MhItemsViewState<T> {
  static const selectionColumnId = "select__col_";
  static const reorderColumnId = "reorder__col_";

  final String debugName;

  final List<T> itemsSource;
  final List<T> filteredItemsSource = [];
  final List<T> filteredItemsSourceUnsorted = [];
  final MhItemsView<T> widget;
  late List<MhItemsViewColumnDef<T>> columnDefs;
  late MhItemsViewSettings<T> settings;
  MhItemsViewTheme theme = MhItemsViewTheme();
  late MhItemsViewTheme themeLight;
  late MhItemsViewTheme themeDark;
  int? colInEditMode;
  bool isTreeView = false;

  final List<MhItemsViewFilterDef<T>> _filterDefs = [];
  final List<MhItemsViewSortDef<T>> _sortDefs = [];

  /// For fast check if item is selected or not
  final Map<T, T> selectedItems = <T, T>{};

  /// Here we keep the items in the order they appear in the list
  final List<T> selectedItemsList = [];

  /// Here we keep the items in the order they were selected. (Last selected item is the last item in this list)
  final List<T> selectedItemsOrderedList = [];

  /// The first column visible in the viewPort
  int firstVisibleColumnIndex = 0;

  /// The last column visible in the viewPort
  int lastVisibleColumnIndex = 0;

  /// The first row visible in the viewPort
  int firstVisibleRowIndex = 0;

  /// The last row visible in the viewPort
  int lastVisibleRowIndex = 0;

  double viewportWidth = 0;
  double viewportHeight = 0;

  /// The width of all collumns = the width of a row
  double rowWidth = 0;

  ///Cache to hold all left Positions of each column
  List<double> colLeftCache = [];

  ///Cache to hold all top Positions of each row
  List<double> rowTopCache = [];

  double headerMoved = 0;

  ChildVicinity? draggedVicinity;

  int? editModeIsRequestedForRow;
  int? editModeIsRequestedForCol;

  T? markedItem;

  void Function() setState;

  MhItemsViewState(
      {required this.widget,
      required this.itemsSource,
      List<MhItemsViewColumnDef<T>>? columnDefs,
      MhItemsViewSettings<T>? settings,
      MhItemsViewTheme? themeLight,
      MhItemsViewTheme? themeDark,
      required this.setState,
      this.debugName = "noName"}) {
    this.columnDefs = columnDefs ?? [MhItemsViewColumnDef.buildDefault<T>()];
    this.settings = settings ?? MhItemsViewSettings<T>();
    this.themeLight = themeLight ?? MhItemsViewTheme();
    this.themeDark = themeDark ?? MhItemsViewTheme();

    // show or remove the selection Column according to the settings
    if (this.settings.selectionSettings.showSelectColumn &&
        !this.columnDefs.any(
            (element) => element.columnType == CdItemsViewColumnTypes.select)) {
      this.columnDefs.insert(
          0,
          MhItemsViewColumnDef(
              id: selectionColumnId,
              columnWidth: 50,
              columnType: CdItemsViewColumnTypes.select));
    }
    if (!this.settings.selectionSettings.showSelectColumn &&
        this.columnDefs.any((element) =>
            element.columnType == CdItemsViewColumnTypes.select &&
            element.id == selectionColumnId)) {
      var colDefSelect = this.columnDefs.firstWhere((element) =>
          element.columnType == CdItemsViewColumnTypes.select &&
          element.id == selectionColumnId);
      this.columnDefs.remove(colDefSelect);
    }

    // show or remove the reorder Column according to the settings
    if (this.settings.dragDropSettings.showReorderColumn &&
        !this.columnDefs.any((element) =>
            element.columnType == CdItemsViewColumnTypes.reorder)) {
      this.columnDefs.insert(
          0,
          MhItemsViewColumnDef(
              id: reorderColumnId,
              columnWidth: 40,
              columnType: CdItemsViewColumnTypes.reorder));
    }
    if (!this.settings.dragDropSettings.showReorderColumn &&
        this.columnDefs.any((element) =>
            element.columnType == CdItemsViewColumnTypes.reorder &&
            element.id == reorderColumnId)) {
      var colDefReorder = this.columnDefs.firstWhere((element) =>
          element.columnType == CdItemsViewColumnTypes.reorder &&
          element.id == reorderColumnId);
      this.columnDefs.remove(colDefReorder);
    }

    refreshFilter();
  }

  bool _displayItem(T item) {
    if (_filterDefs.isEmpty) {
      return true;
    }
    for (var filterDef in _filterDefs) {
      if (!filterDef.displayItem(item)) {
        return false;
      }
    }
    return true;
  }

  void refreshFilter() {
    rowTopCache.clear();
    filteredItemsSource.clear();
    filteredItemsSource.addAll(itemsSource.where((i) {
      return _displayItem(i);
    }));
    filteredItemsSourceUnsorted.clear();
    filteredItemsSourceUnsorted.addAll(filteredItemsSource);
  }

  void sortItems() {
    if (_sortDefs.isEmpty ||
        _sortDefs
            .where((i) => i.sortDirection != MhItemsViewSortDirections.none)
            .isEmpty) {
      filteredItemsSource.clear();
      filteredItemsSource.addAll(filteredItemsSourceUnsorted);
    } else {
      filteredItemsSource.sort((a, b) {
        int ret = 0;
        for (var sortDef in _sortDefs
            .where((i) => i.sortDirection != MhItemsViewSortDirections.none)) {
          var valueA = sortDef.getSortValue(a);
          var valueB = sortDef.getSortValue(b);

          if (sortDef.sortDirection == MhItemsViewSortDirections.desc) {
            // Swap Values
            var valueTemp = valueA;
            valueA = valueB;
            valueB = valueTemp;
          }

          //Compare values
          // - if the values are the same we go to the next sortDef
          // - if the values are not the same we can return the result instandly without caring about the additional sortDefs
          if (valueA is num && valueB is num) {
            var ret = valueA.compareTo(valueB);
            if (ret != 0) {
              return ret;
            }
          } else if (valueA is DateTime && valueB is DateTime) {
            ret = valueA.compareTo(valueB);
            if (ret != 0) {
              return ret;
            }
          } else {
            ret = valueA.toString().compareTo(valueB.toString());
            if (ret != 0) {
              return ret;
            }
          }
        }
        return ret;
      });
    }
    widget._controller.widgetState?.refresh();
  }

  bool isSelected(item) {
    return selectedItems.containsKey(item);
  }

  void addSelectedItem(
      {required T item,
      bool fromSelectBox = false,
      bool fromEditBox = false,
      bool fromDragDrop = false}) {
    if (!fromDragDrop &&
        settings.selectionSettings.selectionMode ==
            MhItemsViewSelectionModes.none) {
      return;
    }

    if (settings.selectionSettings.selectionMode ==
        MhItemsViewSelectionModes.single) {
      // SingleSelection
      if (selectedItems.containsKey(item)) {
        clearSelectedItems();
      } else {
        clearSelectedItems();
        addSelectedItemInner(item);
        orderSelectedItems();
      }
    } else {
      // Multi Selection
      var ctrlIsPressed = HardwareKeyboard.instance.logicalKeysPressed.any(
          (i) =>
              i == LogicalKeyboardKey.controlLeft ||
              i == LogicalKeyboardKey.controlRight ||
              i == LogicalKeyboardKey.control);
      var shiftIsPressed = HardwareKeyboard.instance.logicalKeysPressed.any(
          (i) =>
              i == LogicalKeyboardKey.shiftLeft ||
              i == LogicalKeyboardKey.shiftRight ||
              i == LogicalKeyboardKey.shift);

      if (fromEditBox) {
        if (isSelected(item)) {
          return;
        }
        shiftIsPressed = false;
      }

      if (shiftIsPressed) {
        if (ctrlIsPressed) {
          //Just add the item
          selectedItems[item] = item;
          if (!selectedItems.containsKey(item)) {
            addSelectedItemInner(item);
            orderSelectedItems();
          }
        } else {
          if (selectedItemsOrderedList.isEmpty) {
            //Here we just select the item
            if (!selectedItems.containsKey(item)) {
              addSelectedItemInner(item);
              orderSelectedItems();
            }
          } else {
            //Here we have to select all items from last selected item to this item
            var lastSelectedItem = selectedItemsOrderedList.last;
            var indexOfLastSelectedItem =
                filteredItemsSource.indexOf(lastSelectedItem);
            var indexOfSelectedItem = filteredItemsSource.indexOf(item);
            if (indexOfLastSelectedItem < indexOfSelectedItem) {
              for (var i = indexOfLastSelectedItem;
                  i <= indexOfSelectedItem;
                  i++) {
                var itemToSelect = filteredItemsSource[i];
                if (!selectedItems.containsKey(itemToSelect)) {
                  addSelectedItemInner(itemToSelect);
                }
              }
              orderSelectedItems();
            } else {
              for (var i = indexOfLastSelectedItem;
                  i >= indexOfSelectedItem;
                  i--) {
                var itemToSelect = filteredItemsSource[i];
                if (!selectedItems.containsKey(itemToSelect)) {
                  addSelectedItemInner(itemToSelect);
                }
              }
              orderSelectedItems();
            }
          }
        }
      } else {
        if (ctrlIsPressed || fromSelectBox) {
          //Add this item
          if (!selectedItems.containsKey(item)) {
            addSelectedItemInner(item);
          }
        } else {
          //We select only this item
          clearSelectedItems();
          addSelectedItemInner(item);
        }
        orderSelectedItems();
      }
    }
  }

  void clearSelectedItems() {
    selectedItems.clear();
    selectedItemsList.clear();
    selectedItemsOrderedList.clear();
  }

  void addSelectedItemInner(T item) {
    selectedItems[item] = item;
    selectedItemsOrderedList.add(item);
    selectedItemsList.add(item);
  }

  /// Keep original Order in [selectedItemsList]
  /// This function is relatively slow, do not use it inside a loop - call it at the end of a loop
  void orderSelectedItems() {
    var selectedItemsListTemp = HashSet.from(selectedItemsList);
    selectedItemsList.clear();
    for (var item in itemsSource) {
      if (selectedItemsListTemp.contains(item)) {
        selectedItemsList.add(item);
      }
    }
  }

  void removeSelectedItem(T item) {
    if (selectedItems.containsKey(item)) {
      selectedItems.remove(item);
      selectedItemsList.remove(item);
      selectedItemsOrderedList.remove(item);
    }
  }

  void setMarked(T item, bool isMarked) {
    if (isMarked) {
      markedItem = item;
    } else {
      markedItem = null;
    }
  }

  bool requestEditModeFor(
      T item, int row, int col, MhItemsViewMoveFocusDirections direction) {
    //Move to next cell
    T item = filteredItemsSource[row];
    do {
      switch (direction) {
        case MhItemsViewMoveFocusDirections.up:
          row = row - 1;
          break;
        case MhItemsViewMoveFocusDirections.down:
          row = row + 1;
          break;
        case MhItemsViewMoveFocusDirections.left:
          col = col - 1;
          if (col < 0) {
            row = row - 1;
            col = columnDefs.length - 1;
          }
          break;
        case MhItemsViewMoveFocusDirections.right:
          col = col + 1;
          if (col >= columnDefs.length) {
            row = row + 1;
            col = 0;
          }
          break;
      }
      if (row >= filteredItemsSource.length || row <= 0) {
        return false;
      }
      item = filteredItemsSource[row];
    } while (!columnDefs[col].canEdit(item));

    editModeIsRequestedForRow = row;
    editModeIsRequestedForCol = col;

    //Check to keep the limits
    if (editModeIsRequestedForRow! < 0) {
      editModeIsRequestedForRow = 0;
    }
    if (editModeIsRequestedForRow! >= filteredItemsSource.length) {
      editModeIsRequestedForRow = filteredItemsSource.length - 1;
    }

    addSelectedItem(item: item, fromSelectBox: false, fromEditBox: true);

    // We ensure that the Row is painted in the refresh function (Flutter TextField ensures that it is visible by default - so we just have to care, that the row is painted)
    if (editModeIsRequestedForRow != null) {
      widget.jumpTo(
          item: item, blink: false, centerItem: false, onlyIfNotVisible: true);
    }

    // Refresh the view
    setState();

    return true;
  }

  bool editModeIsRequested(int row, int col) {
    return editModeIsRequestedForRow == row && editModeIsRequestedForCol == col;
  }

  void clearRequestEditMode() {
    editModeIsRequestedForCol = null;
    editModeIsRequestedForRow = null;
    colInEditMode = null;
  }
}
