import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.titleSmall
class MhTitleSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? textColor;

  const MhTitleSmall(
      {super.key,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColorToUse = textColor ?? theme.colorScheme.onSurface;
    var textStyle = theme.textTheme.titleSmall?.copyWith(color: textColorToUse);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Text(
        text,
        style: textStyle,
        overflow: overflow,
      ),
    );
  }
}
