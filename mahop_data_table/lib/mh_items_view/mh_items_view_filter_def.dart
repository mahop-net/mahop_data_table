part of 'mh_items_view.dart';

class MhItemsViewFilterDef<T> {
  bool Function(T item) displayItem;
  MhItemsViewColumnDef<T>? columnDef;

  MhItemsViewFilterDef({
    required this.displayItem,
    this.columnDef,
  });
}
