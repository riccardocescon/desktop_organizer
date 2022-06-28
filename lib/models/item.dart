import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:flutter/material.dart';

abstract class Item {
  String name;
  ItemType itemType;
  Item? parent;
  late Color color;
  Item({
    required this.name,
    required this.itemType,
    required this.parent,
    Color? color,
  }) {
    this.color = color ?? purple.withAlpha(100);
  }

  String getAbsolutePath() {
    if (parent == null) {
      return name;
    } else {
      return "${parent!.getAbsolutePath()}\\$name";
    }
  }

  int getDepth() {
    if (parent == null) {
      return 0;
    } else {
      return parent!.getDepth() + 1;
    }
  }
}
