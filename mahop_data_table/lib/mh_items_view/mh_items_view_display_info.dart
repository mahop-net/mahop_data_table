part of 'mh_items_view.dart';

class MhItemsViewDisplayInfo {
  double height;
  double width;
  ChildVicinity vicinity;
  bool rowIsSelected;

  MhItemsViewDisplayInfo(
      {required this.rowIsSelected,
      required this.height,
      required this.width,
      required this.vicinity});
}
