import 'package:desktop_organizer/utils/enums.dart';
import 'package:flutter/material.dart';

const int mouseMenuAnimationTimeMS = 200;
bool menuOpen = false;

bool mouseMenuOpen = false;

MouseMenuType mouseMenuType = MouseMenuType.file;
double mouseMenuWidth = 200;
Offset? mousePosition;
PageType page = PageType.virtualDesktop;

double sideMenuLength = 100;
