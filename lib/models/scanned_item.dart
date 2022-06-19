import 'dart:io';

import 'package:desktop_organizer/utils/enums.dart';

class ScannedItem {
  String path;
  ItemType itemType;
  List<ScannedItem> childs = [];
  Directory parent;
  ScannedItem({
    required this.path,
    required this.itemType,
    required this.parent,
  });

  String getName() {
    return path.split("\\").last;
  }
}
