import 'dart:developer';
import 'dart:io';

import 'package:desktop_organizer/models/file_structure.dart';
import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/models/scanned_item.dart';

class FileViewData {
  late FileStructure _fileStructure;
  FileViewData() {
    _fileStructure = FileStructure(name: "C:\\", parent: null);
  }

  String getRoot() {
    return _fileStructure.name;
  }

  List<ScannedItem> getChildsItems() {
    return _fileStructure.childFiles;
  }

  List<Item> getItems() {
    List<Item> items = [];
    for (var current in _fileStructure.childDirs) {
      items.add(current);
    }
    for (var current in _fileStructure.childFiles) {
      items.add(current);
    }
    return items;
  }

  void addDirectory(String path) {
    List<String> parts = path.split("\\");
    assert(parts.length > 1);

    FileStructure reference = _fileStructure;
    for (int i = 2; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      var folderRes = _folderExists(
        folderName: parts[i],
        parentPath: reference,
      );
      if (folderRes == null) {
        FileStructure pathFolder =
            FileStructure(name: parts[i], parent: reference);
        reference.childDirs.add(pathFolder);
        reference = pathFolder;
        //log("Created folder: ${parts[i]}");
      } else {
        reference = folderRes;
        //log("Skipped folder: ${parts[i]}");
      }
    }
    log("Saved with path: ${reference.getAbsolutePath()}");
  }

  FileStructure? _folderExists({
    required String folderName,
    required FileStructure parentPath,
  }) {
    for (var current in parentPath.childDirs) {
      if (current.name.replaceAll("\\", "") == folderName) return current;
    }
    return null;
  }
}

extension DirectoryHelper on Directory {
  String get name {
    return path.split("\\").last.isNotEmpty ? path.split("\\").last : "C:\\";
  }
}
