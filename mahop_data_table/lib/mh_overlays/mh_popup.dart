import 'package:flutter/material.dart';

/// A widget that shows a popup relative to a target widget.
///
/// The popup is declaratively shown/hidden using an [OverlayPortalController].
/// It is positioned relative to the target widget using the [followerAnchor] and [targetAnchor] properties.
/// Based on https://lazebny.io/popups-in-flutter/
///
/// ToDo: enhance the positioning of the PopUp in case there is not enought space
/// to show it on the default position
class MhPopup extends StatefulWidget {
  const MhPopup({
    required this.child,
    required this.follower,
    required this.controller,
    required this.popupWidth,
    required this.popupHeight,
    this.offset = Offset.zero,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    super.key,
  });

  /// The target widget that will be used to position the follower widget.
  final Widget child;

  /// The widget that will be positioned relative to the target widget.
  final Widget follower;

  /// The controller that will be used to show/hide the overlay.
  final OverlayPortalController controller;

  /// The alignment of the follower widget relative to the target widget.
  ///
  /// Defaults to [Alignment.topCenter].
  final Alignment followerAnchor;

  /// The alignment of the target widget relative to the follower widget.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final Alignment targetAnchor;

  /// The offset of the follower widget relative to the target widget.
  /// This is useful for fine-tuning the position of the follower widget.
  ///
  /// Defaults to [Offset.zero].
  final Offset offset;

  final double popupWidth;
  final double popupHeight;

  @override
  State<MhPopup> createState() => _MhPopupState();
}

class _MhPopupState extends State<MhPopup> {
  /// The link between the target widget and the follower widget.
  final _layerLink = LayerLink();
  Alignment? targetAnchor;
  Alignment? followerAnchor;

  @override
  Widget build(BuildContext context) {
    targetAnchor ??= widget.targetAnchor;
    followerAnchor ??= widget.followerAnchor;

    return CompositedTransformTarget(
      // Link the target widget to the follower widget.
      link: _layerLink,
      child: OverlayPortal(
        controller: widget.controller,
        child: LayoutBuilder(
          builder: (BuildContext contextInner, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () {
                //ToDo: Optimize automatic positioning of PopUp, because it does NOT handle alle combinations of target and follower Anchor correctly!!!
                // - Especially on small screens this is essential
                // - It also does NOT resize the PopUp Area automatically if it is not fitting on the screen
                targetAnchor = widget.targetAnchor;
                followerAnchor = widget.followerAnchor;
                final renderObject = context.findRenderObject();
                final translation =
                    renderObject?.getTransformTo(null).getTranslation();
                if (translation != null && renderObject?.paintBounds != null) {
                  final offset = Offset(translation.x, translation.y);
                  var screenWidth = MediaQuery.of(context).size.width;
                  var screenHeight = MediaQuery.of(context).size.height;

                  if (widget.targetAnchor == Alignment.bottomCenter ||
                      widget.targetAnchor == Alignment.bottomLeft ||
                      widget.targetAnchor == Alignment.bottomRight) {
                    // Here the default is to display the PopUp below the target
                    if (offset.dy +
                            (context.size?.height ?? 0) +
                            widget.popupHeight >
                        screenHeight) {
                      //Here the PopUp is not fitting below the target => we display it above the target
                      switch (targetAnchor) {
                        case Alignment.bottomCenter:
                          targetAnchor = Alignment.topCenter;
                          break;
                        case Alignment.bottomLeft:
                          targetAnchor = Alignment.topLeft;
                          break;
                        case Alignment.bottomRight:
                          targetAnchor = Alignment.topRight;
                          break;
                      }
                      if (followerAnchor == Alignment.topCenter ||
                          followerAnchor == Alignment.topRight ||
                          followerAnchor == Alignment.topLeft) {
                        //Switch folloverAnchor to the bottom
                        switch (followerAnchor) {
                          case Alignment.topCenter:
                            followerAnchor = Alignment.bottomCenter;
                            break;
                          case Alignment.topRight:
                            followerAnchor = Alignment.bottomRight;
                            break;
                          case Alignment.topLeft:
                            followerAnchor = Alignment.bottomLeft;
                            break;
                        }
                      }
                    }
                  } else {
                    // here the default is to display the PopUp on top of the target
                    if (offset.dy - widget.popupHeight < 0) {
                      //Here the PopUp is not fitting above the target => we display it below the target
                      switch (targetAnchor) {
                        case Alignment.topCenter:
                          targetAnchor = Alignment.bottomCenter;
                          break;
                        case Alignment.topLeft:
                          targetAnchor = Alignment.bottomLeft;
                          break;
                        case Alignment.topRight:
                          targetAnchor = Alignment.bottomRight;
                          break;
                      }
                      //Switch folloverAnchor to the bottom
                      switch (followerAnchor) {
                        case Alignment.bottomCenter:
                          followerAnchor = Alignment.topCenter;
                          break;
                        case Alignment.bottomRight:
                          followerAnchor = Alignment.topRight;
                          break;
                        case Alignment.bottomLeft:
                          followerAnchor = Alignment.topLeft;
                          break;
                      }
                    }
                  }

                  if (followerAnchor == Alignment.bottomRight ||
                      followerAnchor == Alignment.centerRight ||
                      followerAnchor == Alignment.topRight) {
                    if (offset.dx - widget.popupWidth < 0) {
                      //Put the PopUp on the right side
                      switch (targetAnchor) {
                        case Alignment.bottomLeft:
                          targetAnchor = Alignment.bottomRight;
                          break;
                        case Alignment.centerLeft:
                          targetAnchor = Alignment.centerRight;
                          break;
                        case Alignment.topLeft:
                          targetAnchor = Alignment.topRight;
                          break;
                      }
                      switch (followerAnchor) {
                        case Alignment.bottomRight:
                          followerAnchor = Alignment.bottomLeft;
                          break;
                        case Alignment.centerRight:
                          followerAnchor = Alignment.centerLeft;
                          break;
                        case Alignment.topRight:
                          followerAnchor = Alignment.topLeft;
                          break;
                      }
                    }
                  }
                  if (followerAnchor == Alignment.bottomLeft ||
                      followerAnchor == Alignment.centerLeft ||
                      followerAnchor == Alignment.topLeft) {
                    if (offset.dx +
                            (context.size?.width ?? 0) +
                            widget.popupWidth >
                        screenWidth) {
                      //Put the PopUp on the left side
                      switch (targetAnchor) {
                        case Alignment.bottomRight:
                          targetAnchor = Alignment.bottomLeft;
                          break;
                        case Alignment.centerRight:
                          targetAnchor = Alignment.centerLeft;
                          break;
                        case Alignment.topRight:
                          targetAnchor = Alignment.topLeft;
                          break;
                      }
                      switch (followerAnchor) {
                        case Alignment.bottomLeft:
                          followerAnchor = Alignment.bottomRight;
                          break;
                        case Alignment.centerLeft:
                          followerAnchor = Alignment.centerRight;
                          break;
                        case Alignment.topLeft:
                          followerAnchor = Alignment.topRight;
                          break;
                      }
                    }
                  }
                }

                setState(() {
                  targetAnchor = targetAnchor;
                });
                widget.controller.show();
                //return MhPopupOptimalAnchorAndSizeReturn(targetAnchor: targetAnchor, followerAnchor: followerAnchor, width: width, height: height);
                //}
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AbsorbPointer(
                  absorbing: true,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
        overlayChildBuilder: (BuildContext context) {
          return GestureDetector(
            onTap: () => widget.controller.hide(),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // It is needed to wrap the follower widget in a widget that fills the space of the overlay.
              // This is needed to make sure that the follower widget is positioned relative to the target widget.
              // If not wrapped, the follower widget will fill the screen and be positioned incorrectly.
              child: Align(
                child: CompositedTransformFollower(
                  // Link the follower widget to the target widget.
                  link: _layerLink,
                  // The follower widget should not be shown when the link is broken.
                  showWhenUnlinked: false,
                  followerAnchor: followerAnchor!,
                  targetAnchor: targetAnchor!,
                  offset: widget.offset,
                  child: widget.follower,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MhPopupOptimalAnchorAndSizeReturn {
  Alignment targetAnchor;
  Alignment followerAnchor;

  double width;
  double height;

  MhPopupOptimalAnchorAndSizeReturn(
      {required this.targetAnchor,
      required this.followerAnchor,
      required this.width,
      required this.height});
}
