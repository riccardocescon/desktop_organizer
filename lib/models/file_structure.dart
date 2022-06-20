/*
Es:
  C:\\

  C:\\Users\

  C:\\Users\test1
  
  C:\\Users\test2

*/

import 'dart:developer';

import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';

class FileStructure extends Item {
  FileStructure? parent;
  List<FileStructure> childDirs = [];
  List<ScannedItem> childFiles = [];
  FileStructure({required String name, required this.parent})
      : super(name: name, itemType: ItemType.folder);

  FileStructure.clone(FileStructure source)
      : super(name: source.name, itemType: ItemType.folder) {
    parent = source.parent == null
        ? null
        : FileStructure(
            name: source.name,
            parent: FileStructure.clone(source.parent!),
          );
    for (var current in source.childDirs) {
      childDirs.add(
        FileStructure.clone(current),
      );
    }
  }

  String getAbsolutePath() {
    if (parent == null) {
      return name;
    } else {
      return "${parent!.getAbsolutePath()}\\$name";
    }
  }
}
