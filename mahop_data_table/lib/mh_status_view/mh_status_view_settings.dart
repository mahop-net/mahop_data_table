import 'dart:ui';

import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_status_view/mh_status_view.dart';

/// Settings to ajust the design and functionality of the [MhStatusView]
class MhStatusViewSettings<T> {
  final double width = 30;
  final double itemHeight = 2;
  final bool displayFilter = true;
  final bool displaySummay = false;
  final List<MhStatusViewItemsDef<T>> itemsDef;

  MhItemsView<T>? itemsView;

  final double filterPopupWidth;
  final double filterPopupHeight;

  MhStatusViewSettings(
      {required this.itemsDef,
      this.itemsView,
      this.filterPopupWidth = 200,
      this.filterPopupHeight = 200});
}

class MhStatusViewItemsDef<T> {
  Color color;
  double? itemHeight;
  bool displayItems;
  String text;
  bool Function(T item) showItem;
  String Function(T item) tooltipText;
  bool Function(T item)? onTap;

  MhStatusViewItemsDef(
      {required this.text,
      required this.color,
      this.itemHeight,
      required this.showItem,
      required this.tooltipText,
      this.onTap,
      this.displayItems = true});
}
