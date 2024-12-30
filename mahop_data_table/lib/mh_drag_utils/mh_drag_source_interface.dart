import 'package:mahop_data_table/mh_drag_utils/mh_drag_state.dart';

/// Interface for Widgets allowing to start a Drag and Drop Operation
abstract class MdDragSource {
  /// This function is called after the drop was accepted from the drop Target if it was no reorder but a drag and drop between different widgets.
  /// Here you can e.g. remove the dragged items if this was a "move" action, mark them as e.g. assigned or do whatever you need...
  /// If this was a copy action you can e.g. also just ignore this event.
  void dragAcceptedFromTarget(
      MhDragState dragState, List droppedItems, bool removeItemsOnMove);
}
