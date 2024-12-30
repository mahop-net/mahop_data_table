import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_body_medium.dart';
import 'package:mahop_data_table/mh_text/mh_title_large.dart';
import 'package:mahop_data_table/mh_text/mh_title_medium.dart';
import 'package:mahop_data_table/mh_text/mh_title_small.dart';

/// MhFormatedText - Inspired by: https://stackoverflow.com/a/67910495/2775645
/// You can give in a String like a md File but with very limited formatting support
/// Supported are: Lines starting with:
/// #, ##, ### For headlines
/// * For Bold Lines
/// - For Bulleted Lists
class MhFormatedText extends StatelessWidget {
  final String text;

  const MhFormatedText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    var textToUse = text;
    if (textToUse.startsWith('\r\n')) {
      textToUse = textToUse.substring(2);
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: textToUse.split('\n').map(
          (str) {
            if (str == "") {
              return const SizedBox(height: 15);
            }
            if (str.startsWith("# ")) {
              return MhTitleLarge(
                  text: str.substring(2), overflow: TextOverflow.visible);
            }
            if (str.startsWith("## ")) {
              return MhTitleMedium(
                  text: str.substring(3), overflow: TextOverflow.visible);
            }
            if (str.startsWith("### ")) {
              return MhTitleSmall(
                  text: str.substring(4), overflow: TextOverflow.visible);
            }
            if (str.startsWith("* ")) {
              return MhBodyMedium(
                  text: str.substring(2), fontWeight: FontWeight.bold);
            }
            if (str.startsWith("- ")) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('\u2022'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MhBodyMedium(
                      text: str.substring(2),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              );
            }
            return MhBodyMedium(text: str, overflow: TextOverflow.visible);
          },
        ).toList(),
      ),
    );
  }
}
