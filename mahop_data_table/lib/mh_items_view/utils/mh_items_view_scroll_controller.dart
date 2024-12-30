import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MhItemsViewScrollController {
  ScrollController? verticalScrollController;
  Timer? scrollTimer;
  Offset? parentOffset;
  double parentHeight = 0;

  setState({
    required verticalScrollController,
    required parentOffset,
    required parentHeight,
  }) {
    this.verticalScrollController = verticalScrollController;
    this.parentOffset = parentOffset;
    this.parentHeight = parentHeight;
  }

  String onMove(DragTargetDetails<Object?> details) {
    scrollTimer?.cancel();
    scrollTimer = null;
    var scrollArea = 70.0;
    var dy = details.offset.dy - parentOffset!.dy;
    if (dy < scrollArea) {
      var jump = (scrollArea - max(dy, 0));
      scrollTimer ??= Timer.periodic(const Duration(milliseconds: 50), (timer) {
        try {
          if (verticalScrollController!.offset >
              verticalScrollController!.position.minScrollExtent) {
            verticalScrollController
                ?.jumpTo(verticalScrollController!.offset - jump);
          }
        } catch (ex) {/*Nothing to Do*/}
      });
    } else if (dy > (parentHeight - scrollArea)) {
      var jump = (scrollArea - (parentHeight - dy));
      scrollTimer ??= Timer.periodic(const Duration(milliseconds: 50), (timer) {
        try {
          if (verticalScrollController!.offset <
              verticalScrollController!.position.maxScrollExtent) {
            verticalScrollController
                ?.jumpTo(verticalScrollController!.offset + jump);
          }
        } catch (ex) {/*Nothing to Do*/}
      });
    }

    //For Debugging
    var f = NumberFormat("###,##0.0", "de_DE");
    return " offset: ${f.format(dy)} parentHeight: ${f.format(parentHeight)}";
  }

  onLeave() {
    scrollTimer?.cancel();
    scrollTimer = null;
  }
}
