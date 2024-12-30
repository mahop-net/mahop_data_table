import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mh_items_view.dart';

class RenderMhItemsGridViewPort<T> extends RenderTwoDimensionalViewport {
  BuildContext context;

  TwoDimensionalChildManager childManager;

  RenderMhItemsGridViewPort({
    required this.context,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    required this.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  }) : super(childManager: childManager);

  @override
  void layoutChildSequence() {
    var state = context.read<MhItemsViewState<T>>();
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width + cacheExtent;
    final double viewportHeight = viewportDimension.height + cacheExtent;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    final int maxRowIndex = builderDelegate.maxYIndex!;
    final int maxColumnIndex = builderDelegate.maxXIndex!;

    // -------------------------------------------------------------------------------------
    // Check if we have anything to render
    // -------------------------------------------------------------------------------------
    if (state.filteredItemsSource.isEmpty) {
      verticalOffset.applyContentDimensions(
        0.0,
        clampDouble(viewportDimension.height, 0.0, double.infinity),
      );

      horizontalOffset.applyContentDimensions(
        0.0,
        clampDouble(viewportDimension.width, 0.0, double.infinity),
      );
      return;
    }

    state.viewportWidth = viewportDimension.width;
    state.viewportHeight = viewportDimension.width;

    if (state.columnDefs.length == 1 && state.columnDefs[0].columnWidthAuto) {
      state.columnDefs[0].columnWidth = state.viewportWidth;
    }

    // -------------------------------------------------------------------------------------
    // Find first and last Column to display
    //  - right now we don't use this info, but for column virtualisation we will need it...
    // -------------------------------------------------------------------------------------
    int fistVisibleColumnIndex =
        findFirstVisibleCol(state, maxColumnIndex, horizontalPixels);
    int lastVisibleColumnIndex = findLastVisibleCol(maxColumnIndex,
        horizontalPixels, viewportWidth, fistVisibleColumnIndex, state);

    // -------------------------------------------------------------------------------------
    // Find first and last Row to display
    // -------------------------------------------------------------------------------------
    int firstVisibleRowIndex = 0;
    int lastVisibleRowIndex = 0;
    if (state.settings.getRowHeight == null) {
      // Just Calculate the Position according to the fixed row height
      var fixedRowHeight = state.settings.rowHeight;
      firstVisibleRowIndex =
          math.max((verticalPixels / fixedRowHeight).floor(), 0);
      lastVisibleRowIndex = math.min(
          ((verticalPixels + viewportHeight) / fixedRowHeight).ceil(),
          maxRowIndex);
      //We don't need to do this but on other places this makes things easier
      if (state.rowTopCache.isEmpty) {
        fillRowTops(state);
      }
    } else {
      // Here we have a different rowHeight per row
      firstVisibleRowIndex = findFirstVisibleRow(
          state, maxRowIndex, verticalPixels, firstVisibleRowIndex);
      lastVisibleRowIndex = findLastVisibleRow(lastVisibleRowIndex, maxRowIndex,
          verticalPixels, viewportHeight, firstVisibleRowIndex, state);
    }

    //Check for editRequest outside viewPort and make sure to paint this rows and cols
    if (state.editModeIsRequestedForRow != null &&
        state.editModeIsRequestedForRow! < firstVisibleRowIndex) {
      firstVisibleRowIndex = state.editModeIsRequestedForRow!;
    }
    if (state.editModeIsRequestedForRow != null &&
        state.editModeIsRequestedForRow! > lastVisibleRowIndex) {
      lastVisibleRowIndex = state.editModeIsRequestedForRow!;
    }
    if (state.editModeIsRequestedForCol != null &&
        state.editModeIsRequestedForCol! < fistVisibleColumnIndex) {
      fistVisibleColumnIndex = state.editModeIsRequestedForCol!;
    }
    if (state.editModeIsRequestedForCol != null &&
        state.editModeIsRequestedForCol! > lastVisibleColumnIndex) {
      lastVisibleColumnIndex = state.editModeIsRequestedForCol!;
    }

    //Remember the found column and row indices
    updateStateVisibleRowAndColIndices(state, fistVisibleColumnIndex,
        lastVisibleColumnIndex, firstVisibleRowIndex, lastVisibleRowIndex);

    // -------------------------------------------------------------------------------------
    // Care about dragging a row or cell
    // -------------------------------------------------------------------------------------
    if (state.draggedVicinity != null) {
      // We have to draw the dragged item, also if it is out of the viewport - otherwise we would stopp recieving drag events...
      // - Should be optimized
      //   - Right now we draw all colls and rows from the dragged item to the current viewd items
      //   - If we have a very long list of items this leads to performance problems
      //   - It would be bettter to just draw only the dragged items and not all in between
      //
      // - Normally this is not a problem, because if you have verly long lists most of the time it makes no sense to order them via drag and drop...
      //   => So right now this should be fine
      if (fistVisibleColumnIndex > state.draggedVicinity!.xIndex) {
        fistVisibleColumnIndex = state.draggedVicinity!.xIndex;
      }
      if (lastVisibleColumnIndex < state.draggedVicinity!.xIndex) {
        lastVisibleColumnIndex = state.draggedVicinity!.xIndex;
      }
      if (firstVisibleRowIndex > state.draggedVicinity!.yIndex) {
        firstVisibleRowIndex = state.draggedVicinity!.yIndex;
      }
      if (lastVisibleRowIndex < state.draggedVicinity!.yIndex) {
        lastVisibleRowIndex = state.draggedVicinity!.yIndex;
      }
    }

    // -------------------------------------------------------------------------------------
    // Set the min and max scroll extents for each axis.
    // -------------------------------------------------------------------------------------
    setMinMaxScollExtent(maxRowIndex, state, maxColumnIndex);

    // -------------------------------------------------------------------------------------
    // Paint the visible rows
    // -------------------------------------------------------------------------------------
    buildVisibleRows(firstVisibleRowIndex, state, lastVisibleRowIndex);

    // Hint from flutter Team: Super class handles garbage collection too!
  }

  void buildVisibleRows(int firstVisibleRowIndex, MhItemsViewState<T> state,
      int lastVisibleRowIndex) {
    // Right now we paint only a single Row per item - The colls have to be painted into the row container
    //   when painting the cells the code should use state.colLeftCache, state.firstVisibleColumnIndex and state.lastVisibleColumnIndex
    //   to determine what and where to paint
    //   but this is NOT done right now. We would have to build our own caching to invalidate the cache if horizontal Scroll Pos is changed
    double xLayoutOffset = 0 - horizontalOffset.pixels;
    double yLayoutOffset;
    if (state.settings.getRowHeight == null) {
      yLayoutOffset = (firstVisibleRowIndex * state.settings.rowHeight) -
          verticalOffset.pixels;
    } else {
      yLayoutOffset =
          state.rowTopCache[firstVisibleRowIndex] - verticalOffset.pixels;
    }
    for (int row = firstVisibleRowIndex; row <= lastVisibleRowIndex; row++) {
      var item = state.filteredItemsSource[row];
      final ChildVicinity vicinity = ChildVicinity(xIndex: 0, yIndex: row);
      // if (visibleColsChanged) {
      //   markNeedsLayout(withDelegateRebuild: true);
      // }
      final RenderBox child = buildOrObtainChildFor(vicinity)!;
      child.layout(const BoxConstraints());

      // Subclasses only need to set the normalized layout offset. The super
      // class adjusts for reversed axes.
      parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);

      var rowHeightForItem = state.settings.getRowHeight != null
          ? state.settings.getRowHeight!(item)
          : state.settings.rowHeight;
      yLayoutOffset += rowHeightForItem;
    }
  }

  void setMinMaxScollExtent(
      int maxRowIndex, MhItemsViewState<T> state, int maxColumnIndex) {
    double verticalExtent;
    if (state.settings.getRowHeight == null) {
      verticalExtent = (state.settings.rowHeight) * (maxRowIndex + 1);
    } else {
      verticalExtent = state.rowTopCache[maxRowIndex] +
          state.settings.getRowHeight!(state.filteredItemsSource[maxRowIndex]);
    }
    verticalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          verticalExtent - viewportDimension.height, 0.0, double.infinity),
    );

    final double horizontalExtent = state.colLeftCache[maxColumnIndex] +
        state.columnDefs[maxColumnIndex].columnWidth;
    horizontalOffset.applyContentDimensions(
      0.0,
      clampDouble(
          horizontalExtent - viewportDimension.width, 0.0, double.infinity),
    );
    state.rowWidth = horizontalExtent;
  }

  void updateStateVisibleRowAndColIndices(
      MhItemsViewState<dynamic> state,
      int fistVisibleColumnIndex,
      int lastVisibleColumnIndex,
      int firstVisibleRowIndex,
      int lastVisibleRowIndex) {
    //Remember the found column and row indices
    state.firstVisibleColumnIndex = fistVisibleColumnIndex;
    state.lastVisibleColumnIndex = lastVisibleColumnIndex;
    state.firstVisibleRowIndex = firstVisibleRowIndex;
    state.lastVisibleRowIndex = lastVisibleRowIndex;
  }

  int findLastVisibleRow(
      int lastVisibleRowIndex,
      int maxRowIndex,
      double verticalPixels,
      double viewportHeight,
      int firstVisibleRowIndex,
      MhItemsViewState<dynamic> state) {
    //Find the last Row visible - top side is within the viewport
    lastVisibleRowIndex = maxRowIndex;
    double bottom = verticalPixels + viewportHeight;
    for (var i = firstVisibleRowIndex; i <= maxRowIndex; i++) {
      if (state.rowTopCache[i] > bottom) {
        lastVisibleRowIndex = i;
        break;
      }
    }
    return lastVisibleRowIndex;
  }

  int findFirstVisibleRow(MhItemsViewState<T> state, int maxRowIndex,
      double verticalPixels, int firstVisibleRowIndex) {
    // Find the first Row visible - Bottom side of the row is within the viewport
    if (state.rowTopCache.isEmpty) {
      fillRowTops(state);
    }

    var firstVisibleRowIndexDynamic = state.firstVisibleRowIndex;
    if (firstVisibleRowIndexDynamic > maxRowIndex) {
      firstVisibleRowIndexDynamic = maxRowIndex;
    }
    if (state.rowTopCache[firstVisibleRowIndexDynamic] +
            state.settings.getRowHeight!(
                state.filteredItemsSource[firstVisibleRowIndexDynamic]) <
        verticalPixels) {
      //Search down
      for (var i = firstVisibleRowIndexDynamic; i < maxRowIndex; i++) {
        if (state.rowTopCache[i] +
                state.settings.getRowHeight!(state.filteredItemsSource[i]) >
            verticalPixels) {
          firstVisibleRowIndex = i;
          break;
        }
      }
    } else {
      //Search up - Search the fist row not visible any more and use the row below it - if none is found the first row (rowIndex = 0) is visible...
      firstVisibleRowIndex = 0;
      for (var i = firstVisibleRowIndexDynamic; i >= 0; i--) {
        if (state.rowTopCache[i] +
                state.settings.getRowHeight!(state.filteredItemsSource[i]) <
            verticalPixels) {
          firstVisibleRowIndex = i + 1;
          break;
        }
      }
    }
    return firstVisibleRowIndex;
  }

  int findLastVisibleCol(
      int maxColumnIndex,
      double horizontalPixels,
      double viewportWidth,
      int fistVisibleColumnIndex,
      MhItemsViewState<dynamic> state) {
    //Find the last Column visible - left side is within the viewport
    int lastVisibleColumnIndex = maxColumnIndex;
    double right = horizontalPixels + viewportWidth;
    for (var i = fistVisibleColumnIndex; i <= maxColumnIndex; i++) {
      if (state.colLeftCache[i] > right) {
        lastVisibleColumnIndex = i;
        break;
      }
    }
    return lastVisibleColumnIndex;
  }

  int findFirstVisibleCol(
      MhItemsViewState<T> state, int maxColumnIndex, double horizontalPixels) {
    //Find the first Column visible - Right side of the column is within the viewport
    if (state.colLeftCache.isEmpty) {
      fillColLeft(state);
    }

    int fistVisibleColumnIndex = 0;
    var colIndex = state.firstVisibleColumnIndex;
    if (colIndex > maxColumnIndex) colIndex = maxColumnIndex;
    if (state.colLeftCache[colIndex] + state.columnDefs[colIndex].columnWidth <
        horizontalPixels) {
      //Search to the right
      for (var i = colIndex; i < maxColumnIndex; i++) {
        if (state.colLeftCache[i] + state.columnDefs[i].columnWidth >
            horizontalPixels) {
          fistVisibleColumnIndex = i;
          break;
        }
      }
    } else {
      //Search to the left - Search the fist column not visible any more and use the column to the right of it - if none is found the first column (colIndex = 0) is visible...
      fistVisibleColumnIndex = 0;
      for (var i = colIndex; i >= 0; i--) {
        if (state.colLeftCache[i] + state.columnDefs[i].columnWidth <
            horizontalPixels) {
          fistVisibleColumnIndex = i + 1;
          break;
        }
      }
    }

    return fistVisibleColumnIndex;
  }

  void fillColLeft(MhItemsViewState<T> state) {
    state.colLeftCache = [];
    var left = 0.0;
    for (var colDef in state.columnDefs) {
      state.colLeftCache.add(left);
      left += colDef.columnWidth;
    }
  }

  void fillRowTops(MhItemsViewState<T> state) {
    state.rowTopCache = [];

    var top = 0.0;
    if (state.settings.getRowHeight == null) {
      for (var i = 0; i < state.filteredItemsSource.length; i++) {
        state.rowTopCache.add(top);
        top += state.settings.rowHeight;
      }
    } else {
      for (var item in state.filteredItemsSource) {
        state.rowTopCache.add(top);
        top += state.settings.getRowHeight!(item);
      }
    }
  }
}
