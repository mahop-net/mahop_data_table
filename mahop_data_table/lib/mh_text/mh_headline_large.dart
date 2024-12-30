import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.headlineLarge and the given top and bottom padding
class MhHeadlineLarge extends StatelessWidget {
  final String text;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final FontWeight fontWeight;
  final TextOverflow overflow;

  const MhHeadlineLarge(
      {super.key,
      required this.text,
      this.topPadding = 6,
      this.bottomPadding = 6,
      this.textColor,
      this.fontWeight = FontWeight.normal,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColorToUse = textColor ?? theme.colorScheme.onSurface;
    var textStyle = theme.textTheme.headlineLarge
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
