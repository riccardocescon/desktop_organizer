import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:flutter/material.dart';

PageType page = PageType.virtualDesktop;
MouseMenuType mouseMenuType = MouseMenuType.file;

bool menuOpen = false;

double sideMenuLength = 100;
Offset? mousePosition;
bool mouseMenuOpen = false;
double mouseMenuWidth = 200;

const int mouseMenuAnimationTimeMS = 200;

List<ScannedItem> virtualDesktop = [
  ScannedItem(
    name: "School",
    itemType: ItemType.folder,
  ),
  ScannedItem(
    name: "es32.txt",
    itemType: ItemType.file,
  ),
];
