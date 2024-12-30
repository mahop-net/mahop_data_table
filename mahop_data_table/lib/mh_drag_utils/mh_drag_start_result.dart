import '../mh_items_view/mh_items_view.dart';

/// Result for the onDragStart callback
class MhDragStartResult {
  // this is not possible in flutter right now.
  // you need to create the draggable according to your current state
  // to control if a drag should be possible or not
  // set [acceptDrag] to false, to deny the drag
  //bool acceptDrag = true;

  /// set a message to be shown during the complete drag Drop Operation
  String? messageToShowDuringDrag;

  /// [MhItemsView] shows some massages like
  /// - move "Item1" below "Item2"
  ///
  /// set [showDefaultMessages] to false, to tell [MhItemsView]
  /// to NOT display those messages
  bool showDefaultMessages = true;
}
