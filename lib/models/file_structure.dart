/*
Es:
  C:\\

  C:\\Users\

  C:\\Users\test1
  
  C:\\Users\test2

*/

import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/utils/enums.dart';

class FileStructure extends Item {
  List<FileStructure> childDirs = [];
  List<FileStructure> childFiles = [];
  FileStructure({required String name, required Item? parent})
      : super(
          name: name,
          itemType: ItemType.folder,
          parent: parent,
        );

  FileStructure.clone(FileStructure source)
      : super(
          name: source.name,
          itemType: ItemType.folder,
          parent: source.parent,
        ) {
    for (var current in source.childDirs) {
      childDirs.add(
        FileStructure.clone(current),
      );
    }
    for (var current in source.childFiles) {
      childDirs.add(
        FileStructure.clone(current),
      );
    }
  }

  List<Item> get items => [...childDirs, ...childFiles];
}
