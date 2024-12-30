import 'package:flutter/material.dart';

/// Basically the same as a Sized box but with default width and height
class MhSpace extends StatelessWidget {
  final double height;
  final double width;

  const MhSpace({super.key, this.height = 10, this.width = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
