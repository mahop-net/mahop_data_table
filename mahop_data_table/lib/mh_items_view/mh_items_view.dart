import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahop_data_table/mh_drag_utils/mh_drag_source_interface.dart';
import 'package:mahop_data_table/mh_text/mh_title_medium.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mahop_data_table/main.dart';

import '../mh_drag_utils/mh_drag_state.dart';
import '../mh_status_view/mh_status_view.dart';
import '../mh_text/mh_body_medium.dart';
import './utils/mh_items_view_row.dart';
import './utils/mh_items_view_scroll_controller.dart';
import 'mh_items_view_settings.dart';
import 'grid_views/mh_items_grid_view.dart';
import 'mh_items_view_theme.dart';

part 'utils/mh_items_view_controller.dart';
part 'utils/mh_items_view_state.dart';
part 'utils/mh_items_view_cell.dart';
part 'mh_items_view_column_def.dart';
part 'mh_items_view_display_info.dart';
part 'mh_items_view_filter_def.dart';
part 'mh_items_view_sort_def.dart';

/// This is the Main class and Widget of MhItemsView
///
/// MhItemsView can display ItemsView, DataTable, TreeView, TreeListView
///
/// It supports most common scenarios like:
/// - Drag and drop
/// - Reorder via drag and drop
/// - filtering the data
/// - Millions of rows with virtualizing
/// - Inline Edit, multiline edit
/// - and much more.
///
/// For Documentation see:
/// https://flutter.mahop.net and https://flutterdemo.mahop.net
class MhItemsView<T> extends StatefulWidget {
  final List<T> itemsSource;
  final List<MhItemsViewColumnDef<T>>? columnDefs;
  final MhItemsViewSettings<T>? settings;
  final MhItemsViewTheme? theme;
  final MhItemsViewTheme? themeDark;
  final _MhItemsViewController<T> _controller = _MhItemsViewController<T>();
  final String debugName;

  MhItemsView({
    super.key,
    required this.itemsSource,
    this.columnDefs,
    this.settings,
    this.theme,
    this.themeDark,
    this.debugName = "noName",
  });

  @override
  State<MhItemsView<T>> createState() => _MhItemsViewState<T>();

  String getColumnLayoutJson() {
    if (_controller.state == null) {
      return "";
    }
    return jsonEncode(_controller.state!.columnDefs);
  }

  /// Executes the sort definitions and refreshes the [MhItemsView]
  refreshSorting() {
    _controller.state!.sortItems();
    _controller.widgetState!.refresh();
  }

  /// Removes all sort definitions and refreshes the [MhItemsView]
  clearSortDefinitions() {
    _controller.state!._sortDefs.clear();
    refreshSorting();
  }

  /// Builds a default [MhItemsViewSortDef] with the given function and refreshes the [MhItemsView]
  addSortFunction(
      {required Object Function(T item) getSortValue,
      MhItemsViewSortDirections sortDirection =
          MhItemsViewSortDirections.asc}) {
    var sortDef = MhItemsViewSortDef<T>(
        getSortValue: getSortValue, sortDirection: sortDirection);
    addSortDefinition(sortDef);
  }

  /// Adds a sort definition or pushes it to the end if already present and refreshes the [MhItemsView]
  addSortDefinition(MhItemsViewSortDef<T> sortDef) {
    if (_controller.state!._sortDefs.contains(sortDef)) {
      _controller.state!._sortDefs.remove(sortDef);
    }
    _controller.state!._sortDefs.add(sortDef);
    refreshSorting();
  }

  /// Removes all sort definitions and refreshes the [MhItemsView]
  setSortDefinition(
      {required Object Function(T item) getSortValue,
      MhItemsViewSortDirections sortDirection =
          MhItemsViewSortDirections.asc}) {
    clearSortDefinitions();
    addSortFunction(getSortValue: getSortValue, sortDirection: sortDirection);
  }

  /// Executes the filter again over all items and refreshes the [MhItemsView]
  /// call this function for example if the user changed the filter value
  refreshFilter() {
    if (_controller.state == null) {
      return;
    }
    _controller.state!.refreshFilter();
    _controller.widgetState!.refresh();
  }

  /// removes all filters and refreshes the [MhItemsView]
  clearFilter() {
    if (_controller.state == null) {
      return;
    }
    _controller.state!._filterDefs.clear();
    refreshFilter();
  }

  /// adds a Filter and refreshes the [MhItemsView]
  /// multiple filters are combined with logical AND
  /// use only one (complex) filter function to have full control
  /// - inside your custom filter function you can combine
  ///   different checks with OR and AND and so on like you need it...
  addFilter(bool Function(T item) displayItem) {
    if (_controller.state == null) {
      return;
    }
    _controller.state!._filterDefs
        .add(MhItemsViewFilterDef<T>(displayItem: displayItem));
    refreshFilter();
  }

  /// adds a FilterDefinition (if not already present) and refreshes the [MhItemsView]
  /// multiple filters are combined with logical AND
  addFilterDef(MhItemsViewFilterDef<T> filterDef) {
    if (_controller.state == null) {
      return;
    }

    if (_controller.state!._filterDefs.contains(filterDef)) {
      return;
    }
    _controller.state!._filterDefs.add(filterDef);
    refreshFilter();
  }

  /// clears the current filter function(s) and add the given
  /// one as the only filter and refreshes the [MhItemsView]
  setFilter(bool Function(T item) displayItem) {
    clearFilter();
    addFilter(displayItem);
  }

  setColumnLayoutFromJson({required String jsonStr}) {
    if (_controller.state == null) {
      return;
    }
    var map = json.decode(jsonStr);

    // Reorder and set column widths
    var colDefs = _controller.state!.columnDefs.toList(growable: true);
    _controller.state!.columnDefs.clear();
    for (Map colLayout in map) {
      var id = colLayout['id'];
      var width = colLayout['columnWidth'];
      var colDef = colDefs.firstWhereOrNull((i) => i.id == id);
      if (colDef != null) {
        colDef.columnWidth = width;
        _controller.state!.columnDefs.add(colDef);
        colDefs.remove(colDef);
      }
    }

    //Add Columns missing in the Layout
    for (var colDef in colDefs) {
      _controller.state!.columnDefs.add(colDef);
      //TODO hide the column
    }
    _controller.state!.colLeftCache.clear();
    _controller.widgetState!.refresh();
  }

  jumpTo(
      {required T item,
      bool blink = true,
      bool centerItem = true,
      bool onlyIfNotVisible = false}) {
    if (_controller.state == null) {
      return;
    }
    var itemIndex = _controller.state!.filteredItemsSource.indexOf(item);
    if (itemIndex < 0) {
      return;
    }

    if (onlyIfNotVisible) {
      if (itemIndex > _controller.state!.firstVisibleRowIndex &&
          itemIndex < _controller.state!.lastVisibleRowIndex) {
        return; // The row to jump to is already visible
      }
    }

    var itemTop = _controller.state!.rowTopCache[itemIndex];
    var itemHeight = _controller.state!.settings.getRowHeight != null
        ? _controller.state!.settings.getRowHeight!(item)
        : _controller.state!.settings.rowHeight;
    var widgetHeight =
        _controller.widgetState!.itemsViewScrollController.parentHeight;

    double pos = -1;
    if (centerItem) {
      pos = itemTop - ((widgetHeight - itemHeight) / 2);
    } else {
      var currentPos = _controller.widgetState!.vertScrollController.offset;
      var minPos = itemTop - widgetHeight + itemHeight;
      var maxPos = itemTop + widgetHeight - itemHeight;
      if (currentPos < minPos) {
        pos = minPos;
      } else if (currentPos > maxPos) {
        pos = maxPos;
      } else {
        return; //Item is already visible
      }
    }

    _controller.widgetState!.vertScrollController.jumpTo(pos);

    //Blick the item once
    if (blink) {
      Timer(const Duration(milliseconds: 100), () {
        _controller.state!.setMarked(item, true);
        _controller.widgetState!.refresh();
        Timer(const Duration(milliseconds: 500), () {
          _controller.state!.setMarked(item, false);
          _controller.widgetState!.refresh();
        });
      });
    }
  }

  void setItemsSource(List<T> itemsSource) {
    if (_controller.state == null) {
      return;
    }
    _controller.state!.itemsSource.clear();
    _controller.state!.itemsSource.addAll(itemsSource);
    _controller.state!.refreshFilter();
  }
}

class _MhItemsViewState<T> extends State<MhItemsView<T>>
    implements MdDragSource {
  final headerKey = GlobalKey();
  final List<GlobalKey<State<StatefulWidget>>> columnSeperatorKeys = [];

  Timer? timer;
  MhItemsViewState<T>? _state;

  MhItemsViewScrollController itemsViewScrollController =
      MhItemsViewScrollController();

  late ScrollController vertScrollController;
  late ScrollController horScrollController;
  late ScrollController horScrollControllerHeader;

  @override
  void dragAcceptedFromTarget(
      MhDragState dragState, List droppedItems, bool removeItemsOnMove) {
    if (removeItemsOnMove && dragState.dropMode == MhDropMode.move) {
      for (var droppedItem in droppedItems) {
        _state!.itemsSource.remove(droppedItem);
      }
      _state!.refreshFilter();
      _state!.clearSelectedItems();
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    vertScrollController = ScrollController();
    horScrollController = ScrollController();
    horScrollControllerHeader = ScrollController();
  }

  @override
  void dispose() {
    widget._controller.removeListener(() => _stateWasChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget._controller.widgetState = this;
    var provider = Provider<MhItemsViewState<T>>(
      create: (_) {
        //Create the State
        _state = MhItemsViewState<T>(
            widget: widget,
            itemsSource: widget.itemsSource,
            columnDefs: widget.columnDefs,
            settings: widget.settings,
            themeLight: widget.theme,
            themeDark: widget.themeDark,
            setState: () => widget._controller.widgetState?.refresh(),
            debugName: "${widget.debugName}State");
        return _state!;
      },
      builder: (context, child) => buildContent(context),
    );

    widget._controller.addListener(_stateWasChanged);
    return provider;
  }

  _stateWasChanged() {
    _state?.colLeftCache.clear();
  }

  Widget buildContent(BuildContext context) {
    var state = context.read<MhItemsViewState<T>>();
    widget._controller.state = state;

    checkColWidth(context, state);
    applyTheme(context, state);
    checkSelectionState(state);

    //Add handler to selectColumn
    var selectCol = state.columnDefs
        .firstWhereOrNull((i) => i.columnType == CdItemsViewColumnTypes.select);
    if (selectCol != null) {
      selectCol.setSelected = (item, isSelected) {
        setState(() {
          if (isSelected) {
            state.addSelectedItem(item: item, fromSelectBox: true);
          } else {
            state.removeSelectedItem(item);
          }
        });
      };
      selectCol.isSelected = (item) {
        return state.isSelected(item);
      };

      selectCol.areAllSelected = () {
        if (state.selectedItems.length == state.filteredItemsSource.length) {
          return true;
        }
        if (state.selectedItems.isNotEmpty) {
          return null;
        }
        return false;
      };

      selectCol.setAllSelected = (value) {
        setState(() {
          //Clear current Selection
          state.clearSelectedItems();
          if (value) {
            //Select all items
            for (var item in state.filteredItemsSource) {
              state.addSelectedItemInner(item);
            }
            state.orderSelectedItems();
          }
        });
      };
    }

    // Connect ScrollControllers
    horScrollController.addListener(() {
      horScrollControllerHeader.jumpTo(horScrollController.offset);
    });

    horScrollControllerHeader.addListener(() {
      horScrollController.jumpTo(horScrollControllerHeader.offset);
    });

    var scrollbar = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Timer.run(() {
        // If we run this without Timer.Run it is not returning the correct offset on the first build
        Offset? widgetOffset;
        var findRenderObject = context.findRenderObject();
        if (findRenderObject is RenderBox) {
          RenderBox renderBox = findRenderObject;
          widgetOffset = renderBox.localToGlobal(Offset.zero);
        }

        var height = constraints.maxHeight;
        itemsViewScrollController.setState(
            verticalScrollController: vertScrollController,
            parentOffset: widgetOffset,
            parentHeight: height);
      });

      // If there is nothing to be displyed we don't render the ScrollView at all
      if (state.filteredItemsSource.isEmpty) {
        return DragTarget(
          onLeave: (data) => context.read<MhDragState>().onDragLeave(),
          onMove: (details) {
            var dragState = context.read<MhDragState>();
            var dropAllowed = true;
            if (state.settings.dragDropSettings.onDragMove != null) {
              var result = state.settings.dragDropSettings.onDragMove!(
                  context, dragState, null);
              dropAllowed = result.acceptDrop;
            }
            if (!dropAllowedInternal(state, dragState.draggedItems, null)) {
              return;
            }
            var action = dragState.dropMode == MhDropMode.copy
                ? state.settings.textSettings.copy
                : state.settings.textSettings.move;
            var draggedItemsText = dragState.draggedItems!.length == 1
                ? dragState.draggedItems![0].toString()
                : "${dragState.draggedItems!.length} ${state.settings.textSettings.selectedItems}";
            dragState.setDisplayText("$action $draggedItemsText here", true);
            context.read<MhDragState>().onDragMove(dropAllowed);
          },
          onAcceptWithDetails: (details) =>
              onAcceptDrop(state, details, context),
          builder: (context, candidateData, rejectedData) => Center(
            child: Text(state.settings.textSettings.noDataToDisplay),
          ),
        );
      }

      return DragTarget(
        onLeave: (data) => context.read<MhDragState>().onDragLeave(),
        onMove: (details) {
          var dragState = context.read<MhDragState>();
          var dropAllowed = true;
          if (state.settings.dragDropSettings.onDragMove != null) {
            var result = state.settings.dragDropSettings.onDragMove!(
                context, dragState, null);
            dropAllowed = result.acceptDrop;
            dragState.messageToShowDuringMove = result.messageToShowDuringMove;
          }
          if (!dropAllowedInternal(state, dragState.draggedItems, null)) {
            return;
          }
          var action = dragState.dropMode == MhDropMode.copy
              ? state.settings.textSettings.copy
              : state.settings.textSettings.move;
          var draggedItemsText = dragState.draggedItems!.length == 1
              ? dragState.draggedItems![0].toString()
              : "${dragState.draggedItems!.length} ${state.settings.textSettings.selectedItems}";
          dragState.setDisplayText("$action $draggedItemsText here", true);
          context.read<MhDragState>().onDragMove(dropAllowed);
        },
        onAcceptWithDetails: (details) => onAcceptDrop(state, details, context),
        builder: (context, candidateData, rejectedData) => Center(
          child: Scrollbar(
            thumbVisibility: true,
            interactive: true,
            controller: horScrollController,
            thickness: 12.0,
            child: Scrollbar(
              thumbVisibility: true,
              interactive: true,
              thickness: 12.0,
              controller: vertScrollController,
              child: MhItemsGridView<T>(
                verticalDetails: ScrollableDetails(
                    direction: AxisDirection.down,
                    controller: vertScrollController),
                horizontalDetails: ScrollableDetails(
                    direction: AxisDirection.right,
                    controller: horScrollController),
                diagonalDragBehavior: DiagonalDragBehavior.free,
                delegate: TwoDimensionalChildBuilderDelegate(
                  addAutomaticKeepAlives: true,
                  maxXIndex: (state.columnDefs.length) - 1,
                  maxYIndex: state.filteredItemsSource.length - 1,
                  builder: (BuildContext context, ChildVicinity vicinity) {
                    var state = context.read<MhItemsViewState<T>>();
                    var item = state.filteredItemsSource[vicinity.yIndex];
                    var rowHeight = state.settings.getRowHeight != null
                        ? state.settings.getRowHeight!(item)
                        : state.settings.rowHeight;

                    //Build the Row surrounded with a Dragable if needed
                    var row = buildRow(
                        item: item,
                        vicinity: vicinity,
                        rowHeight: rowHeight,
                        state: state);
                    var allowDrag = state.settings.dragDropSettings.allowDrag ||
                        state.settings.dragDropSettings.allowReorder;
                    if (allowDrag &&
                        state.settings.dragDropSettings.dragDropMode ==
                            MhItemsViewDragDropModes.fullRow) {
                      return buildDraggable(
                          item, state, vicinity, context, row);
                    } else {
                      return row;
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });

    //Build the View
    List<Widget> viewItems = [];

    //Add Header
    if (state.settings.displayHeader) {
      viewItems.add(
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                buildColumnHeader(
                    context, state, horScrollControllerHeader, constraints)),
      );
    }

    //Add Content
    viewItems.add(Expanded(
      child: Container(color: state.theme.rowBackgroundColor, child: scrollbar),
    ));

    if (state.settings.statusViewSettings != null) {
      state.settings.statusViewSettings!.itemsView = widget;
      return Row(children: [
        Expanded(
          child: Column(
            children: viewItems,
          ),
        ),
        MhStatusView<T>(
            items: state.filteredItemsSource,
            settings: state.settings.statusViewSettings!)
      ]);
    } else {
      return Column(children: viewItems);
    }

    //}
  }

  void onAcceptDrop(MhItemsViewState<T> state, details, BuildContext context) {
    if (details.data != null) {
      var dragState = context.read<MhDragState>();
      if (dragState.draggedItems != null) {
        dropAccepted(state, dragState.draggedItems!, null);
      }
    }
  }

  Draggable<List<dynamic>> buildDraggable(item, MhItemsViewState<dynamic> state,
      ChildVicinity vicinity, BuildContext context, Widget child) {
    return Draggable(
      dragAnchorStrategy: pointerDragAnchorStrategy,
      data: [item],
      maxSimultaneousDrags: 1,
      onDragStarted: () {
        if (!state.selectedItems.containsKey(item)) {
          state.addSelectedItem(item: item, fromDragDrop: true);
        }
        state.orderSelectedItems();

        // this is needed to keep the dragged items alive
        // otherwise we dont't get the drag Events any more
        state.draggedVicinity = vicinity;

        //fill the dragState
        var dragState = context.read<MhDragState>();
        dragState.draggedItems = state.selectedItemsList.toList();
        dragState.dragSource = this;
        dragState.dropMode = state.settings.dragDropSettings.defaultDropMode;

        if (state.settings.dragDropSettings.onDragStart != null) {
          var result = state.settings.dragDropSettings.onDragStart!(dragState);
          dragState.showDefaultMessages = result.showDefaultMessages;
          dragState.messageToShowDuringDrag = result.messageToShowDuringDrag;
        }
      },
      onDraggableCanceled: (velocity, offset) {
        itemsViewScrollController.onLeave();
        state.draggedVicinity = null;
        if (state.settings.selectionSettings.selectionMode ==
            MhItemsViewSelectionModes.none) {
          state.clearSelectedItems();
        }
      },
      onDragCompleted: () {
        itemsViewScrollController.onLeave();
        setState(() {
          if (state.settings.selectionSettings.selectionMode ==
              MhItemsViewSelectionModes.none) {
            state.clearSelectedItems();
          }
        });
      },
      onDragEnd: (details) {
        itemsViewScrollController.onLeave();
        state.draggedVicinity = null;
        if (state.settings.selectionSettings.selectionMode ==
            MhItemsViewSelectionModes.none) {
          state.clearSelectedItems();
        }
      },
      feedbackOffset: const Offset(0, 0),
      feedback: Consumer<MhDragState>(
        builder:
            (BuildContext context, MhDragState cdDragState, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: state.theme.selectionBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: state.theme.colSeperatorColor!,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  cdDragState.dropMode == MhDropMode.move
                      ? const Icon(Icons.arrow_forward)
                      : cdDragState.dropMode == MhDropMode.copy
                          ? const Icon(Icons.add)
                          : const Icon(Icons.block),
                  cdDragState.dropMode == MhDropMode.notAllowed
                      ? const SizedBox(width: 0)
                      : const SizedBox(width: 10),
                  Text(
                    cdDragState.displayText,
                    style: TextStyle(
                      color: state.theme.selectionTextColor!,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  cdDragState.dropMode == MhDropMode.notAllowed
                      ? const SizedBox(width: 0)
                      : const SizedBox(width: 10),
                ],
              ),
            ),
          );
        },
      ),
      child: child,
    );
  }

  Widget buildRow(
      {required T item,
      required ChildVicinity vicinity,
      required double rowHeight,
      required MhItemsViewState<T> state}) {
    return MhItemsViewRow<T>(
      item: item,
      vicinity: vicinity,
      rowHeight: rowHeight,
      isSelected: state.selectedItems.containsKey(item),
      itemsViewScrollController: itemsViewScrollController,
      cellWasTapped: (item, columnDef) {
        if (state.settings.events.rowTapped != null) {
          state.settings.events.rowTapped!(item, columnDef);
        }
        setState(() {});
      },
      dropAccepted: (droppedItems, targetItem) =>
          dropAccepted(state, droppedItems, targetItem),
      dropAllowedInternal: (state, draggedItems, item) =>
          dropAllowedInternal(state, draggedItems, item),
    );
  }

  void checkSelectionState(MhItemsViewState<T> state) {
    if (state.settings.selectionSettings.selectionMode ==
        MhItemsViewSelectionModes.none) {
      state.clearSelectedItems();
    }
    if (state.settings.selectionSettings.selectionMode ==
            MhItemsViewSelectionModes.single &&
        state.selectedItems.length > 1) {
      state.clearSelectedItems();
    }

    if (state.settings.selectionSettings.showSelectColumn &&
        !state.columnDefs.any(
            (element) => element.columnType == CdItemsViewColumnTypes.select)) {
      state.columnDefs.insert(
          0,
          MhItemsViewColumnDef(
              id: MhItemsViewState.selectionColumnId,
              columnWidth: 50,
              columnType: CdItemsViewColumnTypes.select));
      state.colLeftCache.clear();
    }
    if (state.settings.dragDropSettings.showReorderColumn &&
        !state.columnDefs.any((element) =>
            element.columnType == CdItemsViewColumnTypes.reorder)) {
      state.columnDefs.insert(
          0,
          MhItemsViewColumnDef(
              id: MhItemsViewState.reorderColumnId,
              columnWidth: 40,
              columnType: CdItemsViewColumnTypes.reorder));
      state.colLeftCache.clear();
    }
    if (!state.settings.selectionSettings.showSelectColumn &&
        state.columnDefs.any(
            (element) => element.columnType == CdItemsViewColumnTypes.select)) {
      var colDefSelect = state.columnDefs.firstWhere(
          (element) => element.columnType == CdItemsViewColumnTypes.select);
      state.columnDefs.remove(colDefSelect);
      state.colLeftCache.clear();
    }
  }

  /// Apply the Theme to settings
  void applyTheme(BuildContext context, MhItemsViewState<dynamic> state) {
    //Apply the rowHeight if not set
    var theme = Theme.of(context);
    if (state.settings.rowHeight <= 0) {
      if (theme.dataTableTheme.dataRowMinHeight != null) {
        state.settings.rowHeight = theme.dataTableTheme.dataRowMinHeight!;
      } else {
        state.settings.rowHeight = 35;
      }
    }
    //Security Check
    if (state.settings.rowHeight <= 0) {
      state.settings.rowHeight = 1;
    }

    //Colors
    var mhTheme = MhItemsViewTheme();
    var mhThemeCurrent = state.themeLight;
    if (theme.brightness == Brightness.dark) {
      mhThemeCurrent = state.themeDark;
    }
    mhTheme.rowBackgroundColor =
        mhThemeCurrent.rowBackgroundColor ?? theme.colorScheme.surface;
    mhTheme.textColor = mhThemeCurrent.textColor ?? theme.colorScheme.onSurface;

    mhTheme.headerBackgroundColor = mhThemeCurrent.headerBackgroundColor ??
        theme.colorScheme.surfaceContainerLow;
    mhTheme.headerTextColor =
        mhThemeCurrent.headerTextColor ?? theme.colorScheme.onSurface;

    mhTheme.headerSeperatorColor = mhThemeCurrent.headerSeperatorColor ??
        theme.colorScheme.surfaceContainerHighest;
    mhTheme.rowSeperatorColor = mhThemeCurrent.rowSeperatorColor ??
        theme.colorScheme.surfaceContainerHigh;
    mhTheme.colSeperatorColor = mhThemeCurrent.colSeperatorColor ??
        theme.colorScheme.surfaceContainerHigh;

    mhTheme.markedBackgroundColor = mhThemeCurrent.markedBackgroundColor ??
        theme.colorScheme.tertiaryContainer;
    mhTheme.markedTextColor =
        mhThemeCurrent.markedTextColor ?? theme.colorScheme.onTertiaryContainer;
    mhTheme.selectionBackgroundColor =
        mhThemeCurrent.selectionBackgroundColor ??
            theme.colorScheme.primaryContainer;
    mhTheme.selectionTextColor = mhThemeCurrent.selectionTextColor ??
        theme.colorScheme.onPrimaryContainer;

    var pColor = theme.colorScheme.primaryContainer;
    if (theme.brightness == Brightness.dark) {
      mhTheme.editBackgroundColor = Color.fromARGB(
          255,
          math.min(255, (((pColor.r * 255.0).round() + 15) & 0xff)),
          math.min(255, (((pColor.g * 255.0).round() + 15) & 0xff)),
          math.min(255, (((pColor.b * 255.0).round() + 15) & 0xff)));
    } else {
      mhTheme.editBackgroundColor = Color.fromARGB(
          255,
          math.max(0, (((pColor.r * 255.0).round() - 15) & 0xff)),
          math.max(0, (((pColor.g * 255.0).round() - 15) & 0xff)),
          math.max(0, (((pColor.b * 255.0).round() - 15) & 0xff)));
    }
    mhTheme.editTextColor =
        mhThemeCurrent.editTextColor ?? theme.colorScheme.onPrimaryContainer;

    mhTheme.hoverBackgroundColor = mhThemeCurrent.hoverBackgroundColor ??
        theme.colorScheme.secondaryContainer;
    mhTheme.hoverTextColor =
        mhThemeCurrent.hoverTextColor ?? theme.colorScheme.onSecondaryContainer;

    state.theme = mhTheme;

    // mhTheme.rowBackgroundColor ??= theme.colorScheme.surface;
    // mhTheme.textColor ??= theme.colorScheme.onSurface;

    // mhTheme.headerBackgroundColor ??= theme.colorScheme.surfaceContainerLow;
    // mhTheme.headerTextColor ??= theme.colorScheme.onSurface;

    // mhTheme.headerSeperatorColor ??= theme.colorScheme.surfaceContainerHighest;
    // mhTheme.rowSeperatorColor ??= theme.colorScheme.surfaceContainerHigh;
    // mhTheme.colSeperatorColor ??= theme.colorScheme.surfaceContainerHigh;

    // mhTheme.markedBackgroundColor ??= theme.colorScheme.tertiaryContainer;
    // mhTheme.markedTextColor ??= theme.colorScheme.onTertiaryContainer;
    // mhTheme.selectionBackgroundColor ??= theme.colorScheme.primaryContainer;
    // mhTheme.selectionTextColor ??= theme.colorScheme.onPrimaryContainer;

    // var pColor = theme.colorScheme.primaryContainer;
    // if (theme.brightness == Brightness.dark) {
    //   mhTheme.editBackgroundColor ??= Color.fromARGB(255, math.min(255, pColor.red + 15), math.min(255, pColor.green + 15), math.min(255, pColor.blue + 15));
    // } else {
    //   mhTheme.editBackgroundColor ??= Color.fromARGB(255, math.max(0, pColor.red - 15), math.max(0, pColor.green - 15), math.max(0, pColor.blue - 15));
    // }
    // mhTheme.editTextColor ??= theme.colorScheme.onPrimaryContainer;

    // mhTheme.hoverBackgroundColor ??= theme.colorScheme.secondaryContainer;
    // mhTheme.hoverTextColor ??= theme.colorScheme.onSecondaryContainer;
  }

  Widget buildColumnHeader(BuildContext context, MhItemsViewState<T> state,
      ScrollController horScrollController, BoxConstraints constraints) {
    List<Widget> headerList = [];
    int index = 0;
    for (var colDef in state.columnDefs) {
      headerList.add(
        Container(
          color: state.theme.headerBackgroundColor,
          key: Key('$index'),
          width: colDef.columnWidth,
          child: Row(
            children: [
              Expanded(
                child: ReorderableDragStartListener(
                  index: index,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.move,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: state.theme.headerSeperatorColor!,
                              width: 1),
                        ),
                      ),
                      width: colDef.columnWidth - 5,
                      height: state.settings.headerHeight,
                      child: colDef.buildColumnHeader(context, state),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                key: Key('s$index'),
                cursor: SystemMouseCursors.resizeColumn,
                child: Draggable(
                  onDragUpdate: (details) {
                    setState(() {
                      colDef.virtualColumnWidth += details.delta.dx;
                      if (colDef.virtualColumnWidth > 10) {
                        state.colLeftCache.clear();
                        colDef.columnWidth = colDef.virtualColumnWidth;
                      }
                    });
                  },
                  onDragEnd: (details) {
                    setState(() {
                      state.colLeftCache.clear();
                      colDef.virtualColumnWidth = colDef.columnWidth;
                    });
                  },
                  hitTestBehavior: HitTestBehavior.opaque,
                  axis: Axis.horizontal,
                  feedback: Container(
                    width: 5,
                    height: state.settings.headerHeight,
                    color: state.theme.headerSeperatorColor,
                  ),
                  child: Container(
                    width: 5,
                    height: state.settings.headerHeight,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: state.theme.headerSeperatorColor!, width: 1),
                        bottom: BorderSide(
                            color: state.theme.headerSeperatorColor!, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      index++;
    }
    var list = Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.red,
        shadowColor: Colors.orange,
      ),
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        scrollController: horScrollController,
        buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = state.columnDefs.removeAt(oldIndex);
            state.columnDefs.insert(newIndex, item);
            state.colLeftCache.clear();
          });
        },
        children: headerList,
      ),
    );

    var header = Container(
      key: headerKey,
      color: state.theme.headerBackgroundColor,
      height: state.settings.headerHeight + 1,
      child: list,
    );

    return header;
  }

  colMove(
      BuildContext context,
      MhItemsViewState<T> state,
      DragUpdateDetails details,
      ScrollController horScrollController,
      BoxConstraints constraints) {
    var dx = details.globalPosition.dx;
    var headerContainer =
        headerKey.currentContext?.findRenderObject() as RenderBox;
    var headerRight = headerContainer.localToGlobal(Offset.zero).dx +
        headerContainer.size.width;
    var headerLeft = headerContainer.localToGlobal(Offset.zero).dx;

    //state.headerMoved += details.delta.dx;
    if (dx > headerRight - 100) {
      state.headerMoved = 10;
      startTimer(state, horScrollController);
    } else if (dx > headerRight - 50) {
      state.headerMoved = -20;
      startTimer(state, horScrollController);
    } else if (dx < headerLeft + 100) {
      state.headerMoved = -10;
      startTimer(state, horScrollController);
    } else if (dx < headerLeft + 50) {
      state.headerMoved = -20;
      startTimer(state, horScrollController);
    } else {
      //Stop Scrolling
      state.headerMoved = 0;
      if (timer?.isActive == true) {
        timer?.cancel();
        timer = null;
      }
    }
  }

  void startTimer(
      MhItemsViewState<T> state, ScrollController horScrollController) {
    stopTimer();
    timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      headerScroller(state, horScrollController);
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void headerScroller(
      MhItemsViewState<T> state, ScrollController horScrollController) {
    if (horScrollController.offset + state.headerMoved <
        horScrollController.position.maxScrollExtent) {
      horScrollController
          .jumpTo(horScrollController.offset + state.headerMoved);
    } else {
      timer?.cancel();
      timer = null;
    }

    if (horScrollController.offset < 0) {
      horScrollController.jumpTo(0);
    }
  }

  void checkColWidth(BuildContext context, MhItemsViewState<T> state) {
    if (state.columnDefs.length > 1) {
      for (var colDef in state.columnDefs) {
        if (colDef.columnWidth < 0) {
          colDef.columnWidth = 100;
        }
      }
    }
  }

  bool dropAllowedInternal(
      MhItemsViewState state, List? droppedItems, T? targetItem) {
    //Check if one of the dragged items is also the target and if yes do nothing
    if (droppedItems == null) {
      return false;
    }

    for (var droppedItem in droppedItems) {
      if (droppedItem == targetItem) {
        return false;
      }
    }

    return true;
  }

  dropAccepted(MhItemsViewState<T> state, Object droppedItems, T? targetItem) {
    setState(() {
      var dragState = context.read<MhDragState>();
      if (droppedItems is List<T> && droppedItems.isNotEmpty) {
        var firstdroppedItem = droppedItems[0];

        if (state.itemsSource.contains(firstdroppedItem)) {
          //This is a dragAndDrop within the same control => Reorder
          insertDroppedItems(state, dragState, null, targetItem);
        } else {
          //Items were draged here from another source => Give the outside a change to handle this
          if (state.settings.dragDropSettings.onAcceptDrop != null) {
            var acceptDropResult = state.settings.dragDropSettings
                .onAcceptDrop!(dragState, droppedItems, targetItem);
            if (acceptDropResult.dropAccepted) {
              insertDroppedItems(
                  state, dragState, acceptDropResult.itemsToInsert, targetItem);

              if (dragState.dragSource != null) {
                dragState.dragSource!.dragAcceptedFromTarget(dragState,
                    droppedItems, acceptDropResult.removeItemsOnMove);
              }
              state.refreshFilter();
            }
          }
        }
      }
    });
  }

  insertDroppedItems(MhItemsViewState<T> state, MhDragState dragState,
      List? itemsToInsert, T? targetItem) {
    if (!dropAllowedInternal(state, dragState.draggedItems, targetItem)) {
      return;
    }

    //Remove the dragged items from their original Position
    if (dragState.dropMode == MhDropMode.move) {
      for (var droppedItem in dragState.draggedItems!) {
        state.itemsSource.remove(droppedItem);
      }
    }

    var droppedItems = itemsToInsert ?? dragState.draggedItems!;

    int index;
    if (targetItem == null) {
      index = 0;
    }
    var currentTargetItem = targetItem;
    var droppedItemNo = 0;
    for (var droppedItem in droppedItems) {
      droppedItemNo++;
      // flat list (Not in a tree)
      if (currentTargetItem != null) {
        index = state.itemsSource.indexOf(currentTargetItem);
        if (dragState.dropPosition == null ||
            dragState.dropPosition == MhDropPosition.below ||
            dragState.dropPosition == MhDropPosition.inside ||
            droppedItemNo > 1) {
          index++;
        }
      } else {
        index = state.itemsSource.length;
      }
      state.itemsSource.insert(index, droppedItem);
      currentTargetItem = droppedItem;
    }

    state.refreshFilter();
    if (state.settings.dragDropSettings.itemsChanged != null) {
      state.settings.dragDropSettings.itemsChanged!(state.itemsSource);
    }

    //SetSortPos correctly for all changed items
    if (state.settings.dragDropSettings.getSortPos != null &&
        state.settings.dragDropSettings.setSortPos != null &&
        state.itemsSource.isNotEmpty) {
      // Flat list
      var sortPos = 0;
      for (var item in state.itemsSource) {
        if (state.settings.dragDropSettings.getSortPos!(item) != sortPos) {
          state.settings.dragDropSettings.setSortPos!(item, sortPos);
        }
        sortPos++;
      }
    }
  }
}
