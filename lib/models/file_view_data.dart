import 'dart:io';

import 'package:desktop_organizer/models/file_structure.dart';
import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:flutter/cupertino.dart';

class FileViewData {
  Directory root;
  Directory currentDirectory;
  List<ScannedItem> items;
  final List<String> _fileStructure = [];
  final List<String> _dirStructure = [];
  FileViewData({
    required this.root,
    required this.currentDirectory,
    required this.items,
  });

  void addFolder(String path) {
    _dirStructure.add(
      path,
    );
  }

  void removeFolder(String path) {
    _dirStructure.removeWhere((element) => path == path);
  }

  void addFile(String path) {
    _fileStructure.add(
      path,
    );
  }

  void removeFile(String path) {
    _fileStructure.removeWhere((element) => path == path);
  }
}

extension DirectoryHelper on Directory {
  String get name {
    return path.split("\\").last.isNotEmpty ? path.split("\\").last : "C:\\";
  }
}
