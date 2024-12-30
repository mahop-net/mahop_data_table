part of '../mh_items_view.dart';

class MhItemsViewCell<T> extends StatefulWidget {
  final T item;
  final MhItemsViewColumnDef<T> columnDef;
  final ChildVicinity vicinity;
  final double rowHeight;
  final void Function(T tappedItem, MhItemsViewColumnDef<T> columnDef)
      cellWasTapped;
  final bool rowIsSelected;
  final int row;
  final int col;

  const MhItemsViewCell(
      {super.key,
      required this.item,
      required this.columnDef,
      required this.vicinity,
      required this.rowHeight,
      required this.cellWasTapped,
      required this.rowIsSelected,
      required this.row,
      required this.col});

  @override
  State<MhItemsViewCell<T>> createState() => _MhItemsViewCellState<T>();
}

class _MhItemsViewCellState<T> extends State<MhItemsViewCell<T>> {
  var borderBottom = 0.0;
  var borderTop = 0.0;
  var editMode = false;
  var _ignoreEditFinished = false;
  LogicalKeyboardKey? lastLogicalKey;
  PhysicalKeyboardKey? lastPhysicalKey;
  bool? shiftWasPressedOnLastKey;
  final TextEditingController controller = TextEditingController();
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _ignoreEditFinished = false;
    var state = context.read<MhItemsViewState<T>>();

    if (state.editModeIsRequested(widget.row, widget.col)) {
      editMode = true;
      state.clearRequestEditMode(); //Reset the reqest
    }

    if (editMode) {
      state.colInEditMode = widget.col;

      if (kIsWeb) {
        Future.delayed(const Duration(milliseconds: 100), () {
          focusNode.requestFocus();
        });
      } else {
        focusNode.requestFocus();
      }

      return buildEditControl(state);
    } else {
      return buildCellContent(state);
    }
  }

  LayoutBuilder buildCellContent(MhItemsViewState<T> state) {
    var backgroundColor = state.settings.getRowBackgroundColor == null
        ? Colors.transparent
        : state.settings.getRowBackgroundColor!(widget.item);
    var itemSelected = state.isSelected(widget.item);
    var color = itemSelected && state.colInEditMode == widget.col
        ? state.theme.editBackgroundColor
        : backgroundColor;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            onTapCell(state);
          },
          child: buildDisplayValue(color, context),
        );
      },
    );
  }

  void onTapCell(MhItemsViewState<dynamic> state) {
    if (widget.columnDef.canEdit(widget.item)) {
      //Display Editor it in EditMode
      setState(() {
        editMode = true;
        state.addSelectedItem(
            item: widget.item, fromSelectBox: false, fromEditBox: true);
      });
    } else {
      setState(() {
        if (state.selectedItems.containsKey(widget.item)) {
          state.removeSelectedItem(widget.item);
        } else {
          if (state.settings.selectionSettings.selectionType ==
              MhItemsViewSelectionTypes.fullRow) {
            state.addSelectedItem(item: widget.item);
          }
        }
      });
    }
    widget.cellWasTapped(widget.item, widget.columnDef);
  }

  Container buildDisplayValue(Color? color, BuildContext context) {
    var displayInfo = MhItemsViewDisplayInfo(
      height: widget.rowHeight - 1,
      width: widget.columnDef.columnWidth - 2,
      vicinity: widget.vicinity,
      rowIsSelected: widget.rowIsSelected,
    );

    return Container(
      color: color,
      height: displayInfo.height,
      width: displayInfo.width,
      child: widget.columnDef.buildValue(context, widget.item, displayInfo),
    );
  }

  SizedBox buildEditControl(MhItemsViewState<T> state) {
    return SizedBox(
      height: widget.rowHeight - 1,
      width: widget.columnDef.columnWidth - 1,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        controller.text =
            widget.columnDef.getEditValue(widget.item)?.toString() ?? "";
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
        var padding = (widget.rowHeight -
                (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 0)) /
            2;

        return Focus(
          onKeyEvent: (node, keyEvent) {
            return onKeyEditFocus(keyEvent, state);
          },
          onFocusChange: (hasFocus) {
            onFocusChangedEditFocus(hasFocus, state);
          },
          child: buildEditTextField(context, state, padding),
        );
      }),
    );
  }

  void onFocusChangedEditFocus(bool hasFocus, MhItemsViewState<T> state) {
    if (!hasFocus) {
      setState(() {
        widget.columnDef.setEditValue(state, widget.item, controller.text);
        editMode = false;
        state.colInEditMode = null;
      });
    }
  }

  KeyEventResult onKeyEditFocus(KeyEvent keyEvent, MhItemsViewState<T> state) {
    if (keyEvent is KeyUpEvent) {
      return KeyEventResult.ignored;
    }
    if (keyEvent.logicalKey == LogicalKeyboardKey.tab) {
      setState(() {
        widget.columnDef.setEditValue(state, widget.item, controller.text);
        _ignoreEditFinished = true;
        var direction = MhItemsViewMoveFocusDirections.right;
        if (HardwareKeyboard.instance.isShiftPressed == true) {
          direction = MhItemsViewMoveFocusDirections.left;
        }
        state.requestEditModeFor(
            widget.item, widget.row, widget.col, direction);
        editMode = false;
      });
      return KeyEventResult.handled;
    } else if (keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      setState(() {
        widget.columnDef.setEditValue(state, widget.item, controller.text);
        _ignoreEditFinished = true;
        var direction = MhItemsViewMoveFocusDirections.down;
        if (HardwareKeyboard.instance.isShiftPressed == true) {
          direction = MhItemsViewMoveFocusDirections.up;
        }
        state.requestEditModeFor(
            widget.item, widget.row, widget.col, direction);
        editMode = false;
      });
    }
    return KeyEventResult.ignored;
  }

  TextField buildEditTextField(
      BuildContext context, MhItemsViewState<T> state, double padding) {
    var rowHeight = widget.rowHeight;
    var align = TextAlign.center;
    var a = widget.columnDef.alignment;
    if (a == Alignment.bottomLeft ||
        a == Alignment.topLeft ||
        a == Alignment.centerLeft) {
      align = TextAlign.left;
    }
    if (a == Alignment.bottomRight ||
        a == Alignment.topRight ||
        a == Alignment.centerRight) {
      align = TextAlign.right;
    }

    return TextField(
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: state.theme.editTextColor),
      focusNode: focusNode,
      textAlign: align,
      autofocus: false,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: rowHeight,
            minWidth: widget.columnDef.columnWidth,
            maxWidth: widget.columnDef.columnWidth),
        contentPadding:
            widget.columnDef.padding ?? EdgeInsets.symmetric(vertical: padding),
        fillColor: state.theme.editBackgroundColor,
        filled: true,
      ),
      onEditingComplete: () {
        setState(() {
          if (!_ignoreEditFinished) {
            widget.columnDef.setEditValue(state, widget.item, controller.text);
          }
          editMode = false;
          state.colInEditMode = null;
        });
      },
    );
  }
}
