import 'package:flutter/material.dart';
import 'package:mahop_data_table/main.dart';
import 'package:mahop_data_table/mh_status_view/mh_status_view.dart';

import '../mh_drag_utils/mh_accept_drop_result.dart';
import '../mh_drag_utils/mh_drag_move_result.dart';
import '../mh_drag_utils/mh_drag_start_result.dart';
import '../mh_drag_utils/mh_drag_state.dart';
import '../mh_status_view/mh_status_view_settings.dart';

/// Settings to control the behavior of the [MhItemsView]
class MhItemsViewSettings<T> {
  /// you can use this helper function to calculate / measure the height of a text with a given width (e.g. = colWidth) and fontSize
  /// but be aware, that the performance of this function is not really good
  /// because it has to measure the text and this is a quite complicated thing...
  static double calculateRowHeight(String text, double width, double fontSize) {
    final style = TextStyle(fontSize: fontSize);

    TextPainter textPainter = TextPainter()
      ..text = TextSpan(text: text, style: style)
      ..textDirection = TextDirection.ltr
      ..layout(minWidth: 0, maxWidth: width);

    var height = textPainter.height;
    textPainter.dispose();
    return height;
  }

  /// RowHeight for all Rows if getRowHeight == null
  /// Default is 52
  late double rowHeight;

  /// individual rowHeigth per row / item - if != null [rowHeight] is not used any more
  double Function(T item)? getRowHeight;

  /// individual rowBackground - if not set Colors.Transparent is used
  Color Function(T item)? getRowBackgroundColor;

  /// if true, a header row ist displayed
  /// Default is true
  late bool displayHeader;

  /// if [displayHeader] is true you can set the height of the header row here
  /// Default is 56
  late double headerHeight;

  /// if true and multiselect is active the user can select multiple rows
  /// and any edit will affect all selected rows (in the same column)
  late bool multiLineEdit;

  /// Subscribe to Events of the grid
  late MhItemsViewEvents<T> events = MhItemsViewEvents<T>();

  /// settings to control the selection behavior of [MhItemsView]
  late MhItemsViewSelectionSettings selectionSettings;

  /// settings to control the drag and drop behavior of [MhItemsView]
  late MhItemsViewDragDropSettings<T> dragDropSettings =
      MhItemsViewDragDropSettings<T>();

  /// settings to control or translate all used strings in the [MhItemsView]
  late MhItemsViewTextSettings textSettings = MhItemsViewTextSettings();

  /// settings to control the [MhStatusView] if != null the [MhItemsView] displays a [MhStatusView] on the right side of the [MhItemsView]
  MhStatusViewSettings<T>? statusViewSettings;

  MhItemsViewSettings({
    this.rowHeight = 52,
    this.getRowHeight,
    this.getRowBackgroundColor,
    this.displayHeader = true,
    this.headerHeight = 56,
    this.multiLineEdit = true,
    this.statusViewSettings,
    MhItemsViewSelectionSettings? selectionSettings,
    MhItemsViewDragDropSettings<T>? dragDropSettings,
    MhItemsViewTextSettings? textSettings,
    MhItemsViewEvents<T>? events,
  }) {
    this.selectionSettings =
        selectionSettings ?? MhItemsViewSelectionSettings();
    this.dragDropSettings =
        dragDropSettings ?? MhItemsViewDragDropSettings<T>();
    this.textSettings = textSettings ?? MhItemsViewTextSettings();
    this.events = events ?? MhItemsViewEvents<T>();
  }
}

/// Subscribe to Events of the [MhItemsView]
class MhItemsViewEvents<T> {
  /// This event is called, after a value in a cell was edited
  void Function(T item, MhItemsViewColumnDef<T> columnDef, Object? newValue)?
      valueWasEdited;

  /// This event is called, after a user clicked or tapped on a row
  void Function(T item, MhItemsViewColumnDef<T> columnDef)? rowTapped;

  MhItemsViewEvents({
    this.valueWasEdited,
    this.rowTapped,
  });
}

/// Where a click on any column of the row selects the row or only a click on selectionColumn
/// Important: if set to [MhItemsViewSelectionTypes.selectionColumnOnly] you need to
/// set [MhItemsViewSelectionSettings.showSelectColumn] to true
/// or add a ColumndDef of Type [CdItemsViewColumnTypes.select] to the column definitions
enum MhItemsViewSelectionTypes { fullRow, selectionColumnOnly }

/// none: No Selection allowed,
/// single: only one row can be selected,
/// multiple: one or more rows can be selected.
///
/// On platforms with mouse and keyboard you can also use the SHIFT and CTRL Keys
/// to control selection behavior
enum MhItemsViewSelectionModes { none, single, multiple }

/// Provides settings to control the selection behavior of the [MhItemsView]
class MhItemsViewSelectionSettings {
  /// If you want to combine RowClick => Shows Details or somthing linke this with selection,
  /// you should use [MhItemsViewSelectionTypes.selectionColumnOnly]
  MhItemsViewSelectionTypes selectionType;

  /// Default is [MhItemsViewSelectionModes.none]
  MhItemsViewSelectionModes selectionMode;

  /// If true the grid adds a Selection Column Definition before all
  /// custom columns which is displaying a Checkbox on every Row
  /// and a CheckBox in the Header to select oder deselect all rows
  bool showSelectColumn;

  /// If true the row is highlighted on hover - if a mouse is present
  bool showHoverBackground;

  /// the alpha value (transparency) of the hover effect. Material3.primary is used as a color
  /// the given alpha is applied to the primary color ans used for the overlay of the hover effect
  int hoverBackgroundAlpha;

  MhItemsViewSelectionSettings({
    this.selectionType = MhItemsViewSelectionTypes.fullRow,
    this.selectionMode = MhItemsViewSelectionModes.none,
    this.showSelectColumn = false,
    this.showHoverBackground = false,
    this.hoverBackgroundAlpha = 20,
  });
}

enum MhItemsViewDragDropModes { fullRow, reorderColumnOnly }

/// Provides settings to control the drag and Drop behavior of the [MhItemsView]
class MhItemsViewDragDropSettings<T> {
  /// If true the user can reorder the items via drag and drop
  bool allowReorder;

  /// if true a column with a reorder icon is shown as the first col
  /// ([allowReorder] needs to be true also)
  bool showReorderColumn;

  /// Wether the row can be dragged only with the handle displayed
  /// by the reorder Column or by grabbing the complete row
  ///
  /// If you can edit most or all cells,
  /// it is better to set this mode to [MhItemsViewDragDropModes.reorderColumnOnly]
  MhItemsViewDragDropModes dragDropMode;

  /// If true the user can drag the items
  /// set [allowDrag] to true and use allowDragStart to fine tune the check
  bool allowDrag;

  /// If true the user can drop items here
  /// Set [allowDrop] to true and use [onDragMove] to fine tune the check
  bool allowDrop;

  /// If true the user can drop the items
  MhDropMode defaultDropMode;

  /// How thick the Drop Target Locators should be
  /// Drop Target Locators are lines in primary color, to show the user the position
  /// where the dragged items will be dropped during the dragDrop operation
  /// Default is 5
  double dropTargetBorderThickness = 5;

  /// ---------------------------------------------------
  /// !!! This is not possible in flutter right now
  /// because there is no possibility to cancel
  /// a drag drop Operation from code
  /// Probably because mobile devices dont's have a ESC key...???
  ///
  /// return true, if the selected item or the selected items can be dragged
  /// allowDrag or allowReorder must be true
  /// this callback is called onDragStart
  ///
  /// bool Function(BuildContext context, MhDragState dragState)? allowDragStart;
  /// ---------------------------------------------------

  /// Function is called at the end of a successfull drag drop operation
  /// It is called after setSortPos - so you can use it e.g. to execute a saveChanges.
  void Function(List<T> items)? itemsChanged;

  /// If you allow reorder and this function is set, it is used to sort the items
  /// If within a treeView the sortPos is used to sort the items within the parent
  int Function(T item)? getSortPos;

  /// If you allow reorder this function is used to set the new sort position
  void Function(T item, int sortPos)? setSortPos;

  /// This function is called if a Drag Operation is starting
  /// Inside this function you can manipulate the dragState.
  /// e.g. finetune the allowed Drop Modes according to the items being dragged
  MhDragStartResult Function(MhDragState dragState)? onDragStart;

  /// This function is called on the drag target where the dragged items are beeing dragged over
  /// Inside this function you should manipulate the dragState.
  /// e.g. finetune the allowed Drop Modes according to the items
  /// being dragged and the current targetItem
  ///
  /// Returning  [MhDragMoveResult.acceptDrop] with false will show the user, that a drop is not possible here
  /// [MhDragState] is holding the details of the dragOperation like draggedItems and [MhDropPosition]
  MhDragMoveResult Function(
          BuildContext context, MhDragState dragState, T? dropTargetItem)?
      onDragMove;

  /// This function is called if a Drag Drop Action occured from another [MhItemsView] or another widget
  /// This function should - if needed - create the new items from the list of dropped items and return them
  /// otherwise the droppedItems are used to be integrated into the list
  MhAcceptDropResult Function(
      MhDragState dragState, List<T> droppedItems, T? targetItem)? onAcceptDrop;

  /// This function is called on the source if the target accepted the Drop
  void Function(MhDragState dragState, List<T> droppedItems, T? targetItem)?
      onDropAccepted;

  MhItemsViewDragDropSettings({
    this.allowReorder = false,
    this.showReorderColumn = false,
    this.allowDrag = false,
    this.allowDrop = false,
    this.defaultDropMode = MhDropMode.move,
    this.dragDropMode = MhItemsViewDragDropModes.fullRow,
    this.itemsChanged,
    this.getSortPos,
    this.setSortPos,
    this.onDragMove,
    this.onDragStart,
    this.onAcceptDrop,
    this.onDropAccepted,
  });
}

/// Provides settings to control / translate the texts displayed in [MhItemsView]
class MhItemsViewTextSettings {
  /// Text to be displayed if there is no row to be displayed
  /// (e.g.: If the itemsSource is empty or if the filter did not find any items)
  String noDataToDisplay;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.above} ${targetItem.toString()}"
  /// e.g.: Copy 3 selected items above <widget.item.toString()>
  String selectedItems;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.above} ${targetItem.toString()}"
  /// Copy 3 selected items above <widget.item.toString()>
  /// Move <draggedItem.toString()> above <targetItem.toString()>
  String copy;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.above} ${targetItem.toString()}"
  /// Copy 3 selected items above <widget.item.toString()>
  /// Move <draggedItem.toString()> above <targetItem.toString()>
  String move;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.abbelowove} ${targetItem.toString()}"
  /// Copy 3 selected items below <widget.item.toString()>
  /// Move <draggedItem.toString()> below <targetItem.toString()>
  String below;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.above} ${targetItem.toString()}"
  /// Copy 3 selected items above <widget.item.toString()>
  /// Move <draggedItem.toString()> above <targetItem.toString()>
  String above;

  /// DragAndDrop: The text to be displayed during drag and drop if more than one item is beeing dragged
  /// "$action $draggedItemsText ${state.settings.textSettings.inside} ${targetItem.toString()}"
  /// Copy 3 selected items inside <widget.item.toString()>
  /// Move <draggedItem.toString()> inside <targetItem.toString()>
  String inside;

  MhItemsViewTextSettings({
    this.noDataToDisplay = "No data to display...",
    this.selectedItems = "selected items",
    this.copy = "Copy",
    this.move = "Move",
    this.below = "below",
    this.above = "above",
    this.inside = "inside",
  });
}
