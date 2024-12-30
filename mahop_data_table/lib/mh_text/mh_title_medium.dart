import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.titleMedium
class MhTitleMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? textColor;
  final double paddingTop;
  final double paddingBottom;

  const MhTitleMedium(
      {super.key,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textColor,
      this.paddingTop = 8,
      this.paddingBottom = 8});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColorToUse = textColor ?? theme.colorScheme.onSurface;
    var textStyle =
        theme.textTheme.titleMedium?.copyWith(color: textColorToUse);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, paddingTop, 0, paddingBottom),
      child: Text(
        text,
        style: textStyle,
        overflow: overflow,
      ),
    );
  }
}
