class DemoItem {
  final String pos;
  int index;
  String text;
  String date;
  double? rowHeight;

  DemoItem(
      {required this.pos,
      required this.index,
      required this.text,
      required this.date,
      this.rowHeight = 35});

  @override
  String toString() {
    return "Item $index";
  }
}
