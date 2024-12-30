//import 'dart:math';

import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'demo_item.dart';

class DemoItemGenerator {
  List<DemoItem> generateItems({int count = 1000, bool multiline = false}) {
    var rnd = Random();

    List<DemoItem> ret = [];
    //var random = Random();

    for (var i = 1; i <= count; i++) {
      var text = "A short Text to show for item $i";
      double rowHeight = 35;
      if (multiline) {
        var lines = rnd.nextInt(6);
        for (var line = 1; line < lines; line++) {
          if (kIsWeb) {
            text += "\r\nAnother Text Line with number $line";
          } else {
            text +=
                "${Platform.lineTerminator}Another Text Line with number $line";
          }
          rowHeight += 20;
        }
      }
      ret.add(DemoItem(
          pos: "pos $i",
          index: i,
          text: text,
          date: "2024 1 1",
          rowHeight: rowHeight));

      // since version 3.17 DateTime(...) is pretty slow...
      //ret.add(DemoItem("pos $i", i, "A short Text to show for item $i", DateTime(2024, random.nextInt(11) + 1, random.nextInt(27) + 1)));
    }

    return ret;
  }
}
