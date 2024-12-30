import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.labelLarge
class MhLabelLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const MhLabelLarge(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.labelLarge,
      overflow: overflow,
    );
  }
}
