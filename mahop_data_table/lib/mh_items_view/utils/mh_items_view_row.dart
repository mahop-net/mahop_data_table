import 'package:flutter/material.dart';
import 'package:mahop_data_table/main.dart';
import 'package:provider/provider.dart';

import '../../mh_drag_utils/mh_drag_state.dart';
import '../mh_items_view.dart';
import 'mh_items_view_scroll_controller.dart';

class MhItemsViewRow<T> extends StatefulWidget {
  final T item;
  final ChildVicinity vicinity;
  final double rowHeight;
  final bool isSelected;
  final void Function(Object droppedItems, T targetItem) dropAccepted;
  final MhItemsViewScrollController itemsViewScrollController;
  final void Function(T tappedItem, MhItemsViewColumnDef<T> columnDef)
      cellWasTapped;
  final bool Function(MhItemsViewState state, List? droppedItems, T? targetItem)
      dropAllowedInternal;

  const MhItemsViewRow({
    super.key,
    required this.item,
    required this.vicinity,
    required this.rowHeight,
    required this.isSelected,
    required this.dropAccepted,
    required this.dropAllowedInternal,
    required this.itemsViewScrollController,
    required this.cellWasTapped,
  });

  @override
  State<MhItemsViewRow> createState() => _MhItemsViewRowState<T>();
}

class _MhItemsViewRowState<T> extends State<MhItemsViewRow<T>> {
  var borderBottom = 0.0;
  var borderTop = 0.0;
  var dropInside = false;
  var editMode = false;

  bool _isInHoverState = false;

  @override
  Widget build(BuildContext context) {
    var state = context.read<MhItemsViewState<T>>();
    var findRenderObject = context.findRenderObject();
    Offset? widgetOffset;
    if (findRenderObject is RenderBox) {
      RenderBox renderBox = findRenderObject;
      widgetOffset = renderBox.localToGlobal(Offset.zero);
    }

    //Create the children of the row
    var rowIsSelected = state.isSelected(widget.item);
    List<Widget> cells = createCells(state, rowIsSelected);

    //On a single Col with auto width we set the columnWidth to the viewPortWidth
    if (state.columnDefs.length == 1 && state.columnDefs[0].columnWidthAuto) {
      state.columnDefs[0].columnWidth = state.viewportWidth;
    }

    //Right now we draw all cells for a row...
    // ToDo Column virtualisation
    buildCells(state, cells, rowIsSelected);
    var row = buildRow(widgetOffset, state, cells);
    if (state.settings.selectionSettings.showHoverBackground) {
      row = buildHoverOverlay(context, row, state);
    }
    return row;
  }

  Widget buildHoverOverlay(
      BuildContext context, Widget row, MhItemsViewState state) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var hoverBackgroundColor = Color.fromARGB(
        state.settings.selectionSettings.hoverBackgroundAlpha,
        ((primaryColor.r * 255.0).round() & 0xff),
        ((primaryColor.g * 255.0).round() & 0xff),
        ((primaryColor.b * 255.0).round() & 0xff));
    //var hoverBackgroundColor = primaryColor;
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isInHoverState = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isInHoverState = false;
        });
      },
      child: Stack(
        children: [
          row,
          Positioned.fill(
            child: Container(
              height: 20,
              width: 20,
              color:
                  _isInHoverState ? hoverBackgroundColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(Offset? widgetOffset, MhItemsViewState<dynamic> state,
      List<Widget> cells) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return DragTarget(
          onAcceptWithDetails: (details) {
            onAcceptDrop(details, context);
          },
          onMove: (details) {
            onDragMove(context, details, widgetOffset);
          },
          onLeave: (details) {
            onDragLeave(context);
          },
          builder: (context, c, r) => Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                    color: state.theme.headerSeperatorColor!, width: 1),
                bottom: BorderSide(
                    color: state.theme.headerSeperatorColor!, width: 1),
              ),
            ),
            height: widget.rowHeight - 1,
            width: state.rowWidth,
            child: Stack(children: cells),
          ),
        );
      },
    );
  }

  void onDragLeave(BuildContext context) {
    var dragState = context.read<MhDragState>();
    dragState.onDragLeave();

    setState(() {
      widget.itemsViewScrollController.onLeave();
      dropInside = false;
      borderBottom = 0;
      borderTop = 0;
    });
  }

  void onDragMove(BuildContext context, DragTargetDetails<Object?> details,
      Offset? widgetOffset) {
    var state = context.read<MhItemsViewState<T>>();
    var dragState = context.read<MhDragState>();

    var height = widget.rowHeight;
    var localDy = details.offset.dy - (widgetOffset?.dy ?? 0);

    setState(() {
      widget.itemsViewScrollController.onMove(details);
      if (dragState.draggedItems != null) {
        var draggedItemsText = dragState.draggedItems!.length == 1
            ? dragState.draggedItems![0].toString()
            : "${dragState.draggedItems!.length} ${state.settings.textSettings.selectedItems}";
        dragState.setDragMode();
        var action = dragState.dropMode == MhDropMode.copy
            ? state.settings.textSettings.copy
            : state.settings.textSettings.move;

        if (state.isTreeView) {
          if (localDy < (height / 4)) {
            borderTop =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            borderBottom = 0;
            dropInside = false;
            dragState.setDisplayText(
                "$action $draggedItemsText ${state.settings.textSettings.above} ${widget.item.toString()}",
                true);
            dragState.dropPosition = MhDropPosition.above;
          } else if (localDy < ((height / 4) * 3)) {
            borderTop =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            borderBottom =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            dropInside = true;
            dragState.setDisplayText(
                "$action $draggedItemsText ${state.settings.textSettings.inside} ${widget.item.toString()}",
                true);
            dragState.dropPosition = MhDropPosition.inside;
          } else {
            borderTop = 0;
            borderBottom =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            dropInside = false;
            dragState.setDisplayText(
                "$action $draggedItemsText ${state.settings.textSettings.below} ${widget.item.toString()}",
                true);
            dragState.dropPosition = MhDropPosition.below;
          }
        } else {
          if (localDy < (height / 2)) {
            borderTop =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            borderBottom = 0;
            dropInside = false;
            dragState.setDisplayText(
                "$action $draggedItemsText ${state.settings.textSettings.above} ${widget.item.toString()}",
                true);
            dragState.dropPosition = MhDropPosition.above;
          } else {
            borderTop = 0;
            borderBottom =
                state.settings.dragDropSettings.dropTargetBorderThickness;
            dropInside = false;
            dragState.setDisplayText(
                "$action $draggedItemsText ${state.settings.textSettings.below} ${widget.item.toString()}",
                true);
            dragState.dropPosition = MhDropPosition.below;
          }
        }
      }

      var dragAllowed = widget.dropAllowedInternal(
          state, dragState.draggedItems, widget.item);
      if (state.settings.dragDropSettings.onDragMove != null) {
        var result = state.settings.dragDropSettings.onDragMove!(
            context, dragState, widget.item);
        dragAllowed = result.acceptDrop;
      }

      dragState.onDragMove(dragAllowed);
    });
  }

  void onAcceptDrop(DragTargetDetails<Object?> details, BuildContext context) {
    setState(() {
      borderBottom = 0;
      borderTop = 0;
      dropInside = false;
    });
    if (details.data != null) {
      var dragState = context.read<MhDragState>();
      if (dragState.draggedItems != null) {
        widget.dropAccepted(dragState.draggedItems!, widget.item);
      }
    }
  }

  void buildCells(
      MhItemsViewState<T> state, List<Widget> cells, bool rowIsSelected) {
    for (var colIndex = 0; colIndex < state.columnDefs.length; colIndex++) {
      var colDef = state.columnDefs[colIndex];
      cells.add(Positioned(
        left: state.colLeftCache[colIndex],
        width: colDef.columnWidth,
        height: widget.rowHeight,
        top: 0,
        child: MhItemsViewCell<T>(
          item: widget.item,
          row: widget.vicinity.yIndex,
          col: colIndex,
          rowIsSelected: rowIsSelected,
          columnDef: colDef,
          vicinity: widget.vicinity,
          rowHeight: widget.rowHeight,
          cellWasTapped: (tappedItem, columnDef) {
            setState(() {
              widget.cellWasTapped(tappedItem, columnDef);
            });
          },
        ),
      ));
    }
  }

  List<Widget> createCells(
      MhItemsViewState<dynamic> state, bool rowIsSelected) {
    var cells = <Widget>[];
    cells.add(
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: state.markedItem == widget.item
              ? state.theme.markedBackgroundColor
              : rowIsSelected || dropInside
                  ? state.theme.selectionBackgroundColor
                  : state.theme.rowBackgroundColor,
          border: Border(
            top: borderTop == 0
                ? BorderSide(color: Colors.transparent, width: borderTop)
                : BorderSide(
                    color: state.theme.selectionBackgroundColor!,
                    width: borderTop),
            bottom: borderBottom == 0
                ? BorderSide(color: Colors.transparent, width: borderBottom)
                : BorderSide(
                    color: state.theme.selectionBackgroundColor!,
                    width: borderBottom),
          ),
        ),
      ),
    );

    // Create not all visible Cells in a row
    // This is a problem, because on horizontal scroll the row is reused and the layout is not calling this => cols invisible before the horizontal scoll are not drawn...
    // for (var colIndex = state.firstVisibleColumnIndex; colIndex <= state.lastVisibleColumnIndex; colIndex++) {
    //   var colDef = state.columnDefs[colIndex];
    //   cells.add(Positioned(
    //     left: state.colLeftCache[colIndex],
    //     width: colDef.columnWidth,
    //     height: widget.rowHeight,
    //     top: 0,
    //     child: CdItemsViewCell<T>(
    //       item: widget.item,
    //       columnDef: colDef,
    //       vicinity: widget.vicinity,
    //       rowHeight: widget.rowHeight,
    //       cellWasTapped: (tappedItem, columnDef) {
    //         setState(() {
    //           widget.cellWasTapped(tappedItem, columnDef);
    //         });
    //       },
    //     ),
    //   ));
    // }
    return cells;
  }
}
