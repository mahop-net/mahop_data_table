import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import '../../utils/example_view.dart';

class ScrollTestView2 extends StatefulWidget {
  const ScrollTestView2({super.key});

  @override
  State<ScrollTestView2> createState() => _ScrollTestView2State();
}

class _ScrollTestView2State extends State<ScrollTestView2> {
  ScrollController vertScrollController = ScrollController();
  ScrollController horScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ExampleView(
      header: "Flutter Test Scroll 2",
      code: "",
      help: const SizedBox(),
      child: buildScrollTester(context),
    );
  }

  Widget buildScrollTester(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      interactive: true,
      controller: horScrollController,
      thickness: 12.0,
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        thickness: 12.0,
        controller: vertScrollController,
        child: TwoDimensionalGridView(
          diagonalDragBehavior: DiagonalDragBehavior.none,
          horizontalDetails: ScrollableDetails(
              direction: AxisDirection.right, controller: horScrollController),
          verticalDetails: ScrollableDetails(
              direction: AxisDirection.down, controller: vertScrollController),
          delegate: TwoDimensionalChildBuilderDelegate(
              maxXIndex: 9,
              maxYIndex: 9,
              builder: (BuildContext context, ChildVicinity vicinity) {
                return Container(
                  color: vicinity.xIndex.isEven && vicinity.yIndex.isEven
                      ? Colors.amber[50]
                      : (vicinity.xIndex.isOdd && vicinity.yIndex.isOdd
                          ? Colors.purple[50]
                          : null),
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Text(
                          'Row ${vicinity.yIndex}: Column ${vicinity.xIndex}')),
                );
              }),
        ),
      ),
    );
  }
}

class TwoDimensionalGridView extends TwoDimensionalScrollView {
  const TwoDimensionalGridView({
    super.key,
    super.primary,
    super.mainAxis = Axis.vertical,
    super.verticalDetails,
    super.horizontalDetails,
    required TwoDimensionalChildBuilderDelegate delegate,
    super.cacheExtent,
    super.diagonalDragBehavior = DiagonalDragBehavior.none,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return TwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }
}

class TwoDimensionalGridViewport extends TwoDimensionalViewport {
  const TwoDimensionalGridViewport({
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildBuilderDelegate super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  });

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return RenderTwoDimensionalGridViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildBuilderDelegate,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderTwoDimensionalGridViewport renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..cacheExtent = cacheExtent
      ..clipBehavior = clipBehavior;
  }
}

class RenderTwoDimensionalGridViewport extends RenderTwoDimensionalViewport {
  RenderTwoDimensionalGridViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildBuilderDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
  }) : super(delegate: delegate);

  double _lastHorizontalDimmension = -1;
  double _lastVerticalDimmension = -1;

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final double viewportWidth = viewportDimension.width + cacheExtent;
    final double viewportHeight = viewportDimension.height + cacheExtent;
    final TwoDimensionalChildBuilderDelegate builderDelegate =
        delegate as TwoDimensionalChildBuilderDelegate;

    final int maxRowIndex = builderDelegate.maxYIndex!;
    final int maxColumnIndex = builderDelegate.maxXIndex!;

    final int leadingColumn = math.max((horizontalPixels / 200).floor(), 0);
    final int leadingRow = math.max((verticalPixels / 200).floor(), 0);
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportWidth) / 200).ceil(),
      maxColumnIndex,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportHeight) / 200).ceil(),
      maxRowIndex,
    );

    double xLayoutOffset = (leadingColumn * 200) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset = (leadingRow * 200) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox child = buildOrObtainChildFor(vicinity)!;
        child.layout(constraints.loosen());

        // Subclasses only need to set the normalized layout offset. The super
        // class adjusts for reversed axes.
        parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);
        yLayoutOffset += 200;
      }
      xLayoutOffset += 200;
    }

    // Set the min and max scroll extents for each axis.
    final double verticalExtent = 200 * (maxRowIndex + 1);
    final double verticalDimmension = clampDouble(
        verticalExtent - viewportDimension.height, 0.0, double.infinity);
    if (verticalDimmension != _lastVerticalDimmension) {
      _lastVerticalDimmension = verticalDimmension;
      verticalOffset.applyContentDimensions(
        0.0,
        verticalDimmension,
      );
    }

    final double horizontalExtent = 200 * (maxColumnIndex + 1);
    final double horizontalDimension = clampDouble(
        horizontalExtent - viewportDimension.width, 0.0, double.infinity);
    if (_lastHorizontalDimmension != horizontalDimension) {
      _lastHorizontalDimmension = horizontalDimension;
      horizontalOffset.applyContentDimensions(
        0.0,
        horizontalDimension,
      );
    }

    // Super class handles garbage collection too!
  }
}
