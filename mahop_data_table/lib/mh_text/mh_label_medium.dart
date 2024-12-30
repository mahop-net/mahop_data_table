import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.labelMedium and the given top and bottom padding
class MhLabelMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const MhLabelMedium(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.labelMedium,
      overflow: overflow,
    );
  }
}
