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

  void addDirectory(String path) {
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
  }

  List<Item> getItems() {
    return _currentStructure.items;
  }

  String getRoot() {
    return _virtualDesktopData.name;
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

  void removeDirectory(Item directory) {
    var res = _currentStructure.childDirs.firstWhere(
      (element) => element.getAbsolutePath() == directory.getAbsolutePath(),
    );
    _currentStructure.childDirs.remove(res);
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
