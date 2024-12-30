import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.bodySmall and the given top and bottom padding
class MhBodySmall extends StatelessWidget {
  final String text;
  final double topPadding;
  final double bottomPadding;
  final TextOverflow overflow;
  final Color? textColor;
  final FontWeight fontWeight;

  const MhBodySmall(
      {super.key,
      required this.text,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.overflow = TextOverflow.ellipsis,
      this.textColor,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColorToUse = textColor ?? theme.colorScheme.onSurface;
    var textStyle = theme.textTheme.bodyMedium
        ?.copyWith(color: textColorToUse, fontWeight: fontWeight);
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Text(
        text,
        style: textStyle,
        overflow: overflow,
      ),
    );
  }
}
