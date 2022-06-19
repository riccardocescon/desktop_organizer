import 'dart:developer';
import 'dart:io';

import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';

List<ScannedItem> scanFolder({required String path}) {
  Directory dir = Directory(path);
  var res = dir.listSync();
  List<ScannedItem> items = [];
  for (var current in res) {
    items.add(
      ScannedItem(
        path: current.path,
        itemType: current is File ? ItemType.file : ItemType.folder,
        parent: current.parent,
      ),
    );
  }
  return items;
}
