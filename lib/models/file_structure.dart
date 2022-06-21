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
  FileStructure? fileStructureparent;
  List<FileStructure> childDirs = [];
  List<ScannedItem> childFiles = [];
  FileStructure({required String name, required this.fileStructureparent})
      : super(
            name: name, itemType: ItemType.folder, parent: fileStructureparent);

  FileStructure.clone(FileStructure source)
      : super(
            name: source.name,
            itemType: ItemType.folder,
            parent: source.fileStructureparent) {
    fileStructureparent = source.fileStructureparent == null
        ? null
        : FileStructure(
            name: source.name,
            fileStructureparent:
                FileStructure.clone(source.fileStructureparent!),
          );
    for (var current in source.childDirs) {
      childDirs.add(
        FileStructure.clone(current),
      );
    }
  }

  List<Item> getItems() {
    List<Item> items = [];
    for (var current in childDirs) {
      items.add(current);
    }
    for (var current in childFiles) {
      items.add(current);
    }
    return items;
  }
}
