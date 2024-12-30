import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.labelSmall and the given top and bottom padding
class MhLabelSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const MhLabelSmall(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.labelSmall,
      overflow: overflow,
    );
  }
}
