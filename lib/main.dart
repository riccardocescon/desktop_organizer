import 'dart:io';

import 'package:desktop_organizer/pages/homepage.dart';
import 'package:desktop_organizer/utils/navigation.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(1270, 720));
  }
  runApp(
    MaterialApp(
      initialRoute: Navigation.homepage,
      routes: {
        Navigation.homepage: (context) => const Homepage(),
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
            backgroundColor: appbarColor,
            toolbarTextStyle: TextStyle(
              color: textColor,
            )),
        scaffoldBackgroundColor: backgroundColor,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
    ),
  );
}
