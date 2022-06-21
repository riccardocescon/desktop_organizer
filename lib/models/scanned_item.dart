import 'dart:io';

import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/utils/enums.dart';

class ScannedItem extends Item {
  String path;
  List<ScannedItem> childs = [];
  Directory scannedItemParent;
  ScannedItem({
    required this.path,
    required ItemType itemType,
    required this.scannedItemParent,
  }) : super(
          name: path.split("\\").last,
          itemType: ItemType.file,
          parent: null,
        );

  String getName() {
    return path.split("\\").last;
  }
}
