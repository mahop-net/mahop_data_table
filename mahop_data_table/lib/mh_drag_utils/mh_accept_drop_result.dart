/// Accept the drop or deny it. To deney it set [dropAccepted] to false
///
/// Create new items to be inserted from the dragged items
/// and fill [itemsToInsert]
///
/// If [itemsToInsert] is empty the dragged items will be inserted
/// into the target
class MhAcceptDropResult {
  /// To deny the drop set [dropAccepted] to false
  bool dropAccepted = true;

  /// set [removeItemsOnMove] to false, to avoid that
  /// the items are beeing removed from the source
  /// and the default actions are running
  bool removeItemsOnMove = true;

  /// Fill with new items to be inserted into the target
  List? itemsToInsert;
}
