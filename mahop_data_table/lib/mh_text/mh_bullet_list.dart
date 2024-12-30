import 'package:flutter/material.dart';
import 'package:mahop_data_table/mh_text/mh_body_medium.dart';

/// BulletList - Inspired by: https://stackoverflow.com/a/67910495/2775645
/// Display a list of text lines with a bullet infront of each line from a given String Array
class MhBulletList extends StatelessWidget {
  final List<String> strings;

  const MhBulletList(this.strings, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map(
          (str) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  str == "" ? "" : '\u2022',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MhBodyMedium(
                    text: str,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
