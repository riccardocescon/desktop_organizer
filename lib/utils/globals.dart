import 'dart:io';

import 'package:desktop_organizer/models/file_view_data.dart';
import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/utils.dart';
import 'package:flutter/material.dart';

PageType page = PageType.virtualDesktop;
MouseMenuType mouseMenuType = MouseMenuType.file;

bool menuOpen = false;

double sideMenuLength = 100;
Offset? mousePosition;
bool mouseMenuOpen = false;
double mouseMenuWidth = 200;

const int mouseMenuAnimationTimeMS = 200;

FileViewData realDekstop = FileViewData();
