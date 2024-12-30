part of 'mh_items_view.dart';

enum CdItemsViewColumnTypes {
  select,
  reorder,
  string,
  bool,
  int,
  decimal,
  date,
  time,

  image,
}

class MhItemsViewColumnDef<T> {
  static MhItemsViewColumnDef<T> buildDefault<T>() {
    return MhItemsViewColumnDef<T>(id: "default");
  }

  late String id;
  late String _header;
  late Widget Function(BuildContext context, MhItemsViewState<T> state)
      _buildColumnHeader;
  late Widget Function(
          BuildContext context, T item, MhItemsViewDisplayInfo displayInfo)
      _buildValue;

  late Object? Function(T) _getDisplayValue;
  late Object? Function(T) _getEditValue;
  late void Function(T, Object?)? _setEditValue;
  bool Function(T item)? allowEdit;
  late CdItemsViewColumnTypes columnType;

  Alignment alignment;
  EdgeInsetsGeometry? padding;

  late MhItemsViewSortDef<T> _sortDef;
  bool _showSortIcon = false;

  /// If true the user can sort the Items by cklicking on the sort Icon in the header
  bool allowSorting;

  /// if given, the value for sorting is used from this function, else getDisplayValue is used
  Object Function(T item)? getSortValue;

  /// If true the Sort Icon is shown on hover and not always
  bool showSortIconOnHover = true;

  void Function(T item, bool isSelected)? setSelected;
  bool Function(T item)? isSelected;
  bool? Function()? areAllSelected;
  void Function(bool isSelected)? setAllSelected;

  bool _columnWidthAuto = false;
  double _columnWidth = 100;
  double virtualColumnWidth = 100;

  MhItemsViewColumnDef({
    required this.id,
    String? header,
    Widget Function(BuildContext, MhItemsViewState<T>)? buildColumnHeader,
    double? columnWidth,
    CdItemsViewColumnTypes? columnType,
    Widget Function(
            BuildContext context, T item, MhItemsViewDisplayInfo displayInfo)?
        buildDisplay,
    Object? Function(T)? getDisplayValue,
    this.alignment = Alignment.center,
    this.padding,
    Widget Function(T)? buildEdit,
    Object? Function(T)? getEditValue,
    void Function(T, Object?)? setEditValue,
    this.allowEdit,
    this.allowSorting = false,
    this.getSortValue,
  }) {
    //Type
    if (columnType == null) {
      this.columnType = CdItemsViewColumnTypes.string;
    } else {
      this.columnType = columnType;
    }

    //Column Header
    if (buildColumnHeader != null) {
      _buildColumnHeader = buildColumnHeader;
    } else {
      switch (this.columnType) {
        case CdItemsViewColumnTypes.select:
          _buildColumnHeader = (context, state) {
            if (state.settings.selectionSettings.selectionMode ==
                MhItemsViewSelectionModes.multiple) {
              return Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Checkbox(
                  value: areAllSelected?.call(),
                  tristate: true,
                  onChanged: (bool? value) {
                    setAllSelected?.call(value == true);
                  },
                ),
              );
            }
            return const SizedBox();
          };
          break;
        case CdItemsViewColumnTypes.reorder:
          _buildColumnHeader = (context, state) {
            return const SizedBox();
          };
          break;
        default:
          _header = header ?? "";
          _buildColumnHeader = (context, state) {
            var textColor = state.theme.headerTextColor;
            return Center(
                child: MhTitleMedium(
                    text: _header,
                    textColor: textColor,
                    paddingTop: 0,
                    paddingBottom: 0));
          };
          break;
      }
    }

    //Value
    if (buildDisplay != null) {
      _buildValue = buildDisplay;
    } else {
      switch (columnType) {
        case CdItemsViewColumnTypes.select:
          _buildValue = (context, item, rowIsSelected) => Center(
                child: Checkbox(
                  value: isSelected?.call(item),
                  onChanged: (bool? value) {
                    setSelected?.call(item, value == true);
                  },
                ),
              );
          break;

        case CdItemsViewColumnTypes.reorder:
          _buildValue = (context, item, displayInfo) {
            var state = context.read<MhItemsViewState<T>>();

            var allowDrag = state.settings.dragDropSettings.allowReorder ||
                state.settings.dragDropSettings.allowDrag;
            if (allowDrag &&
                state.settings.dragDropSettings.dragDropMode ==
                    MhItemsViewDragDropModes.reorderColumnOnly) {
              return state.widget._controller.widgetState!.buildDraggable(
                  item,
                  state,
                  displayInfo.vicinity,
                  context,
                  const Center(
                      child:
                          Opacity(opacity: 0.3, child: Icon(Icons.reorder))));
            }
            return const Center(
                child: Opacity(opacity: 0.3, child: Icon(Icons.reorder)));
          };
          break;

        case CdItemsViewColumnTypes.bool:
          _buildValue = (context, item, rowIsSelected) => Center(
                  child: Checkbox(
                value: getDisplayValueBool(item),
                onChanged: (bool? value) {
                  setEditValue?.call(item, value);
                },
              ));
          break;
        default:
          _buildValue = (context, item, displayInfo) {
            var state = context.read<MhItemsViewState<T>>();
            return Align(
                alignment: alignment,
                child: MhBodyMedium(
                  text: getDisplayValue?.call(item)?.toString() ?? "",
                  textColor: displayInfo.rowIsSelected
                      ? state.theme.selectionTextColor
                      : state.theme.textColor,
                  topPadding: 0,
                  bottomPadding: 0,
                ));
          };
          break;
      }
    }

    _getEditValue = getEditValue ?? (item) => item.toString();
    _setEditValue = setEditValue;
    _getDisplayValue = getDisplayValue ?? (item) => item.toString();

    //Settings
    if (columnWidth != null) {
      this._columnWidth = columnWidth;
      this.virtualColumnWidth = columnWidth;
    } else {
      this._columnWidthAuto = true;
    }

    // Prepare for Sorting
    if (!showSortIconOnHover) {
      _showSortIcon = true;
    }
    _sortDef = MhItemsViewSortDef<T>(
        getSortValue: _getSortValue,
        columnDef: this,
        sortDirection: MhItemsViewSortDirections.none);
  }

  Object _getSortValue(T item) {
    if (getSortValue != null) {
      return getSortValue!(item);
    }
    return _getDisplayValue(item) ?? "";
  }

  bool? getDisplayValueBool(T item) {
    var val = _getDisplayValue(item);
    if (val is bool) {
      return val;
    }
    return null;
  }

  void setEditValue(MhItemsViewState<T> state, T item, String value) {
    if (state.settings.multiLineEdit) {
      for (var i in state.selectedItemsList) {
        _setEditValue?.call(i, value);
      }
    } else {
      _setEditValue?.call(item, value);
    }
    if (state.settings.events.valueWasEdited != null) {
      state.settings.events.valueWasEdited!(item, this, value);
    }
  }

  bool canEdit(T item) {
    if (allowEdit != null) {
      if (!allowEdit!(item)) {
        return false;
      }
    }
    return _setEditValue != null;
  }

  Object? getEditValue(T item) {
    return _getEditValue(item);
  }

  bool get columnWidthAuto {
    return _columnWidthAuto;
  }

  double get columnWidth {
    return _columnWidth;
  }

  set columnWidth(double value) {
    _columnWidth = value;
    virtualColumnWidth = value;
  }

  Widget buildColumnHeader(BuildContext context, MhItemsViewState<T> state) {
    var columnHeader = _buildColumnHeader(context, state);
    if (allowSorting) {
      columnHeader = _buildColumnHeaderSortIcon(context, columnHeader);
    }
    return columnHeader;
  }

  Widget _buildColumnHeaderSortIcon(BuildContext context, Widget columnHeader) {
    var state = context.read<MhItemsViewState<T>>();

    var directionIcon = Icons.clear;
    if (state._sortDefs.contains(_sortDef)) {
      if (_sortDef.sortDirection == MhItemsViewSortDirections.asc) {
        directionIcon = Icons.south;
      } else if (_sortDef.sortDirection == MhItemsViewSortDirections.desc) {
        directionIcon = Icons.north;
      }
    } else {
      _sortDef.sortDirection = MhItemsViewSortDirections.none;
    }

    return MouseRegion(
      onEnter: (event) {
        _showSortIcon = true;
        state.widget._controller.widgetState?.refresh();
      },
      onExit: (event) {
        if (showSortIconOnHover) {
          _showSortIcon = false;
        }
        state.widget._controller.widgetState?.refresh();
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          columnHeader,
          Positioned(
              right: 6,
              width: 25,
              height: 25,
              child: Container(
                color: _showSortIcon
                    ? state.theme.headerBackgroundColor
                    : Colors.transparent,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (_sortDef.sortDirection ==
                          MhItemsViewSortDirections.none) {
                        _sortDef.sortDirection = MhItemsViewSortDirections.asc;
                      } else if (_sortDef.sortDirection ==
                          MhItemsViewSortDirections.asc) {
                        _sortDef.sortDirection = MhItemsViewSortDirections.desc;
                      } else {
                        _sortDef.sortDirection = MhItemsViewSortDirections.none;
                      }
                      if (!HardwareKeyboard.instance.isShiftPressed) {
                        state.widget.clearSortDefinitions();
                      }
                      state.widget.addSortDefinition(_sortDef);
                    },
                    child: !_showSortIcon
                        ? const SizedBox()
                        : Stack(children: [
                            const Positioned.fill(
                                top: 2, child: Icon(Icons.sort)),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: Icon(directionIcon, size: 10)),
                            )
                          ]),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget buildValue(
      BuildContext context, T item, MhItemsViewDisplayInfo displayInfo) {
    return _buildValue(context, item, displayInfo);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'columnWidth': _columnWidth,
    };
  }
}
