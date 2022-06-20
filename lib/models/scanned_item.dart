import 'dart:io';

import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/utils/enums.dart';

class ScannedItem extends Item {
  String path;
  List<ScannedItem> childs = [];
  Directory parent;
  ScannedItem({
    required this.path,
    required ItemType itemType,
    required this.parent,
  }) : super(name: path.split("\\").last, itemType: ItemType.file);

  String getName() {
    return path.split("\\").last;
  }
}
