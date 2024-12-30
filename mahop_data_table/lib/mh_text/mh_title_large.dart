import 'package:flutter/material.dart';

/// A Widget to display Text using the text style primaryTextTheme.titleLarge
class MhTitleLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const MhTitleLarge(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.titleLarge,
      overflow: overflow,
    );
  }
}
