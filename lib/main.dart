import 'package:desktoop_organizer/pages/homepage.dart';
import 'package:desktoop_organizer/utils/enums.dart';
import 'package:desktoop_organizer/utils/navigation.dart';
import 'package:desktoop_organizer/utils/style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
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
      scrollBehavior: MaterialScrollBehavior().copyWith(
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
