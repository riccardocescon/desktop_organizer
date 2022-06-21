import 'dart:developer';

import 'package:desktop_organizer/models/file_structure.dart';
import 'package:desktop_organizer/models/file_view_data.dart';
import 'package:desktop_organizer/models/item.dart';

class VirtualDesktopHelper {
  static final VirtualDesktopHelper _instance =
      VirtualDesktopHelper._internal();

  late FileViewData _virtualDesktopData;

  late FileStructure _currentStructure;

  factory VirtualDesktopHelper() {
    return _instance;
  }

  bool get isOnRoot => _currentStructure.parent != null;

  VirtualDesktopHelper._internal() {
    _virtualDesktopData = FileViewData();
    _currentStructure = _virtualDesktopData.getStructure();
  }

  String getRoot() {
    return _virtualDesktopData.getRoot();
  }

  List<Item> getItems() {
    return _currentStructure.getItems();
  }

  void addDirectory(String path) {
    _virtualDesktopData.addDirectory(path);
  }

  void openDirectory(String path) {
    List<String> parts = path.split("\\");
    assert(parts.length > 1);

    _currentStructure = _virtualDesktopData.getStructure();

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
