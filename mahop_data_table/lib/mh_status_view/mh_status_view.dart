import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_items_view/mh_items_view.dart';
import 'package:mahop_data_table/mh_overlays/mh_popup.dart';
import 'package:mahop_data_table/mh_status_view/mh_status_view_settings.dart';

/// A Status View is a Widget displaying a view like VS Code or most mordern Code Editors have on the right side
/// of the edit area left to the vertical Scrollbar
///
/// It can show the status or whatever of each item in a listview or [MhItemsView]
/// Use [MhStatusViewSettings] to control the layout and functionality of the StatusView
class MhStatusView<T> extends StatefulWidget {
  final MhStatusViewSettings<T> settings;
  final List<T> items;

  const MhStatusView({super.key, required this.items, required this.settings});

  @override
  State<MhStatusView<T>> createState() => _MhStatusViewState<T>();
}

class _MhStatusViewState<T> extends State<MhStatusView<T>> {
  double filterHeight = 30;
  double summaryHeight = 30;
  Alignment? followerAnchor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      width: widget.settings.width,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: widget.settings.width,
          height: constraints.maxHeight,
          child: Stack(children: buildContent(context, constraints)),
        );
      }),
    );
  }

  List<Widget> buildContent(BuildContext context, BoxConstraints constraints) {
    var ret = List<Widget>.empty(growable: true);

    var height = constraints.maxHeight;
    double virtualTop = 0;
    if (widget.settings.displayFilter) {
      //todo: Display the icon for the filter

      ret.add(buildFilter(context));

      height -= filterHeight;
      virtualTop += filterHeight;
    }

    if (widget.settings.displaySummay) {
      //todo: Display the icon for the summary
      height -= summaryHeight;
      virtualTop += summaryHeight;
    }

    height -= 15; //Border bottom

    var virtualItemHeight = height / widget.items.length;
    var itemWidth = widget.settings.width - 8;
    for (var def in widget.settings.itemsDef) {
      var top = virtualTop;
      var itemHeight = def.itemHeight ?? widget.settings.itemHeight;
      for (var item in widget.items) {
        if (def.displayItems && def.showItem(item)) {
          var itemWidget = buildItem(itemWidth, itemHeight, def);
          var tooltipWidget = buildTooltipAroundItem(def, item, itemWidget);
          var gestureDetectorWidget =
              buildGestureDetectorAroundItem(def, item, tooltipWidget);
          ret.add(buildItemContainer(top, gestureDetectorWidget));
        }
        top += virtualItemHeight;
      }
    }

    return ret;
  }

  Positioned buildItemContainer(
      double top, GestureDetector gestureDetectorWidget) {
    return Positioned(
      top: top,
      left: 0,
      child: gestureDetectorWidget,
    );
  }

  GestureDetector buildGestureDetectorAroundItem(
      MhStatusViewItemsDef<T> def, item, Tooltip tooltipWidget) {
    return GestureDetector(
      onTap: () {
        if (def.onTap != null) {
          def.onTap!(item);
        } else if (widget.settings.itemsView != null) {
          widget.settings.itemsView!.jumpTo(item: item);
        }
      },
      child: tooltipWidget,
    );
  }

  Tooltip buildTooltipAroundItem(
      MhStatusViewItemsDef<T> def, item, Padding itemWidget) {
    return Tooltip(
      decoration: BoxDecoration(color: def.color),
      message: def.tooltipText(item),
      child: Container(
        color: Colors.transparent,
        child: itemWidget,
      ),
    );
  }

  Padding buildItem(
      double itemWidth, double itemHeight, MhStatusViewItemsDef<T> def) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        color: def.color,
      ),
    );
  }

  Widget buildFilter(BuildContext filterContext) {
    var controller = OverlayPortalController();
    var mhPopup = MhPopup(
      popupWidth: 200,
      popupHeight: 200,
      controller: controller,
      targetAnchor: Alignment.topRight,
      followerAnchor: Alignment.bottomRight,
      follower: buildFilterPopup(filterContext),
      child: SizedBox(
        width: widget.settings.width,
        height: filterHeight,
        child: IconButton(
          padding: const EdgeInsets.all(1.0),
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
          ),
        ),
      ),
    );

    return mhPopup;
  }

  Widget buildFilterPopup(BuildContext context) {
    List<Widget> items = List<Widget>.empty(growable: true);
    for (var def in widget.settings.itemsDef) {
      items.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              def.displayItems = !def.displayItems;
            });
          },
          child: Container(
            color: Colors.transparent,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: def.displayItems
                          ? const Icon(Icons.check,
                              color: Colors.green, size: 16)
                          : Icon(Icons.check_box_outline_blank_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              size: 16),
                    ),
                  ),
                  Text(def.text),
                ],
              ),
            ),
          ),
        ),
      ));
    }

    var verticalScrollController = ScrollController();

    return Container(
      width: widget.settings.filterPopupWidth,
      height: widget.settings.filterPopupHeight,
      decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          border: Border.all(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              width: 3)),
      child: Scrollbar(
        controller: verticalScrollController,
        thumbVisibility: true,
        child: ListView(
          controller: verticalScrollController,
          children: items,
        ),
      ),
    );
  }
}
