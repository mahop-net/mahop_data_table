import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mahop_data_table/mh_drag_utils/mh_drag_state.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';

/// This class enables Reorder and Drag and Drop for [MhItemsView] in all children
/// It wraps all Children with [MhDragState] and a [KeyboardListener]
/// the KeyBoard Listener is required to handle Key events during a drag Drop Operation
/// like STRG (copy)
/// and SHIFT (move),
/// and ESC (Cancel - ToDo / MayBe this is not possible in flutter)
class MhDragDropProvider extends StatefulWidget {
  final Widget child;
  const MhDragDropProvider({super.key, required this.child});

  @override
  State<MhDragDropProvider> createState() => _MhDragDropProviderState();
}

class _MhDragDropProviderState extends State<MhDragDropProvider> {
  final _focusNode = FocusNode();
  final _dragState = MhDragState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MhDragState>(
      create: (_) {
        return _dragState;
      },
      child: KeyboardListener(
        focusNode: _focusNode,
        child: widget.child,
        onKeyEvent: (event) {
          _dragState.onKeyEvent(event);
        },
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
