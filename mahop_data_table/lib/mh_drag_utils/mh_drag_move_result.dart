/// Result for the onMove Callback
class MhDragMoveResult {
  /// Set [acceptDrop] to false, to deny a drop here
  bool acceptDrop = true;

  /// Here you can set a message to be shown to the user
  /// while dragging over the target
  String? messageToShowDuringMove;
}
