part of 'mh_items_view.dart';

enum MhItemsViewSortDirections { none, asc, desc }

class MhItemsViewSortDef<T> {
  Object Function(T item) getSortValue;
  MhItemsViewColumnDef<T>? columnDef;
  MhItemsViewSortDirections sortDirection;

  MhItemsViewSortDef({
    required this.getSortValue,
    this.columnDef,
    this.sortDirection = MhItemsViewSortDirections.none,
  });
}
