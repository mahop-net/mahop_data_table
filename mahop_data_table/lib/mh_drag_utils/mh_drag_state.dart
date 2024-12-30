import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mh_drag_source_interface.dart';

/// class to hold the current State of a drag and drop operation
/// ---------
/// A drag drop operation has different states
///
/// - dragStart
///   The User wants to drag something
///   this is called on dragSources - e.g. Flutter Draggable
///   You can disallow the drag here
///
/// - dragMove
///   The User is dragging around something
///   this is called on DragTargets - e.g. Flutter DragTarget
///   You can set the allowed dropModes here
///   also according to the current position
///
/// - acceptDrop
///   The Users wants to drop something
///   this is called on DragTargets - e.g. Flutter DragTarget
///   Here you can accept the drop or deny it. And
///   you chould create the items to be inserted from the
///   dropped items. E.g.: If you drop items from a List
///   to a TreeView and the TreeView need different items
///   than the list, than you should create a new item from
///   every dragged item
///
/// - dropAccepted
///   The Drop Target accepted the drop
///   this is called on the DragSource
///   e.g. Flutter Draggeable.onDragEnd
///   Here you can e.g. remove the dragged items from the List
///   if this was a move operation
///
/// There are more states, but in most cases you don't need them, so we decided to handle them internally or ignore them
class MhDragState extends ChangeNotifier {
  // Private stuff
  String _displayText = "";
  MhDropMode _dropModeRemembered = MhDropMode.move;
  bool _showDefaultMessages = true;
  String? _messageToShowDuringDrag;
  String? _messageToShowDuringMove;

  /// holds a list of items beeing dragged
  List? draggedItems;

  /// points to the widget the where the drag operation started and the draggedItems are taken from
  MdDragSource? dragSource;

  /// holds the position where the user wants to drop the draggedItems according to the current Pointer position
  MhDropPosition? dropPosition;

  /// the current action the user requestet for the drag and drop Operation
  MhDropMode _dropMode = MhDropMode.move;

  /// the modes which are allowed for the current drag drop Operation
  /// you can limit the allowed drop modes to only copy, only move or do both
  MhDropModeAllowed dropModeAllowed = MhDropModeAllowed.copyAndMove;

  /// Text to be displayed during a drag and drop operation
  /// holding e.g.: Move <DraggedItemToString> below <TargetItemToString>
  String get displayText {
    if (_dropMode == MhDropMode.notAllowed) {
      return "";
    }
    return _displayText;
  }

  /// the current action the user requestet for the drag and drop Operation
  MhDropMode get dropMode {
    return _dropMode;
  }

  /// set the dropMode
  set dropMode(MhDropMode value) {
    _dropModeRemembered = value;
    _dropMode = value;
  }

  /// set the text to be displayed close to the cursor during a drag and drop operation
  void setDisplayText(String value, bool isDefaultMessage) {
    if (isDefaultMessage && !_showDefaultMessages) {
      _displayText = "";
    } else {
      _displayText = value;
    }

    if (_messageToShowDuringDrag != null &&
        _messageToShowDuringDrag!.trim() != "") {
      if (_displayText != "") {
        _displayText += '\n';
      }
      _displayText += _messageToShowDuringDrag!;
    }

    if (_messageToShowDuringMove != null &&
        _messageToShowDuringMove!.trim() != "") {
      if (_displayText != "") {
        _displayText += '\n';
      }
      _displayText += _messageToShowDuringMove!;
    }

    notifyListeners();
  }

  set showDefaultMessages(bool value) {
    _showDefaultMessages = value;
  }

  set messageToShowDuringDrag(String? value) {
    _messageToShowDuringDrag = value;
  }

  set messageToShowDuringMove(String? value) {
    _messageToShowDuringMove = value;
  }

  /// called from the KeyBoard listener to indicate a key was pressed during the drag drop operation
  void onKeyEvent(KeyEvent event) {
    setDragMode();
    notifyListeners();
  }

  /// set the current drag Drop Mode according to current Keys Pressed e.g. if the users presses the SHIFT key, the drop Mode is set to move if allowed
  void setDragMode() {
    if (HardwareKeyboard.instance.isControlPressed) {
      if (dropModeAllowed == MhDropModeAllowed.copy ||
          dropModeAllowed == MhDropModeAllowed.copyAndMove) {
        dropMode = MhDropMode.copy;
      }
    } else if (HardwareKeyboard.instance.isShiftPressed) {
      if (dropModeAllowed == MhDropModeAllowed.copy ||
          dropModeAllowed == MhDropModeAllowed.copyAndMove) {
        dropMode = MhDropMode.move;
      }
    }
  }

  /// call this funtion to tell the drag drop operation if the cursor is currently over a DropTarget or not
  void _setIsDropAllowed(bool isDropAllowed) {
    if (isDropAllowed) {
      _dropMode = _dropModeRemembered;
    } else {
      if (_dropMode != MhDropMode.notAllowed) {
        _dropModeRemembered = _dropMode;
      }
      _dropMode = MhDropMode.notAllowed;
    }
    notifyListeners();
  }

  /// function should be called from every DragTarget in the onLeave Event
  onDragLeave() {
    _setIsDropAllowed(false);
    messageToShowDuringMove = null;
  }

  /// function should be called from every DragTarget in the move Event
  onDragMove(bool dragAllowed) {
    _setIsDropAllowed(dragAllowed);
  }
}

/// position of the drop if accepted now
enum MhDropPosition { above, below, inside }

/// tells the target and source what to do with the dragged objects after the drop was accepted
enum MhDropMode { copy, move, notAllowed }

/// drop modes wich are allowed
enum MhDropModeAllowed { copy, move, copyAndMove }
