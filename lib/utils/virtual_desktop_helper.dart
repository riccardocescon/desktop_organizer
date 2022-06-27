import 'dart:developer';

import 'package:desktop_organizer/models/file_structure.dart';
import 'package:desktop_organizer/models/item.dart';

class VirtualDesktopHelper {
  static final VirtualDesktopHelper _instance =
      VirtualDesktopHelper._internal();

  late FileStructure _virtualDesktopData;

  late FileStructure _currentStructure;

  factory VirtualDesktopHelper() {
    return _instance;
  }

  VirtualDesktopHelper._internal() {
    _virtualDesktopData = FileStructure(
      name: "C:\\",
      parent: null,
    );
    _currentStructure = _virtualDesktopData;
  }

  bool get isOnRoot => _currentStructure.parent != null;

  FileStructure addDirectory(String path) {
    List<String> parts = path.split("\\");
    assert(parts.length > 1);

    FileStructure reference = _virtualDesktopData;
    for (int i = 2; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      var folderRes = _folderExists(
        folderName: parts[i],
        parentPath: reference,
      );
      if (folderRes == null) {
        FileStructure pathFolder = FileStructure(
          name: parts[i],
          parent: reference,
        );
        reference.childDirs.add(pathFolder);
        reference = pathFolder;
        //log("Created folder: ${parts[i]}");
      } else {
        reference = folderRes;
        //log("Skipped folder: ${parts[i]}");
      }
    }
    log("Saved with path: ${reference.getAbsolutePath()}");
    return reference;
  }

  addStructure(FileStructure structure) {
    _virtualDesktopData.childDirs.add(structure);
  }

  String getCurrentDirectoryPath() {
    return _currentStructure.getAbsolutePath();
  }

  List<Item> getItems() {
    return _currentStructure.items;
  }

  String getRoot() {
    return _virtualDesktopData.name;
  }

  List<Item> mouseMenuOpenDirectoryAndGetItems(String path) {
    VirtualDesktopHelper clone = VirtualDesktopHelper._internal();
    clone._virtualDesktopData = _virtualDesktopData;
    clone._currentStructure = _virtualDesktopData;
    clone.openDirectory(path);
    return clone.getItems();
  }

  void moveFilStructureWithChildrenToNewPath(
    String oldPath,
    String newPath,
  ) {
    FileStructure newStructure = addDirectory(newPath);
    openDirectory(oldPath);
    for (FileStructure structure in _currentStructure.childDirs) {
      structure.parent = newStructure;
      newStructure.childDirs.add(structure);
    }
    _currentStructure.childDirs.clear();
    //get parent oldPath path
    String parentPath = oldPath.substring(0, oldPath.lastIndexOf("\\"));
    openDirectory(parentPath);

    //get oldPath item name
    String oldPathItemName = oldPath.substring(oldPath.lastIndexOf("\\") + 1);
    //remove oldPath item from parent
    _currentStructure.childDirs
        .removeWhere((item) => item.name == oldPathItemName);
  }

  void openDirectory(String path) {
    List<String> parts = path.split("\\");
    assert(parts.length > 1);

    _currentStructure = _virtualDesktopData;

    for (int i = 2; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;
      var folderRes = _folderExists(
        folderName: parts[i],
        parentPath: _currentStructure,
      );
      if (folderRes == null) {
        throw ("Folder ${parts[i]} not found!");
      } else {
        _currentStructure = folderRes;
      }
    }
  }

  void parentDirectory() {
    if (_currentStructure.parent == null) {
      log("You're on the root, you cannot go back anymore!");
      return;
    }
    openDirectory(_currentStructure.parent!.getAbsolutePath());
  }

  FileStructure removeDirectory(Item directory) {
    FileStructure res = _currentStructure.childDirs.firstWhere(
      (element) => element.getAbsolutePath() == directory.getAbsolutePath(),
    );
    _currentStructure.childDirs.remove(res);
    return res;
  }

  void renameItem(Item item, String newName) {
    item.name = newName;
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
