import 'package:desktoop_organizer/utils/enums.dart';
import 'package:desktoop_organizer/utils/globals.dart';
import 'package:desktoop_organizer/utils/style.dart';
import 'package:desktoop_organizer/utils/widgets.dart';
import 'package:flutter/material.dart';

Widget sideMenu({required BuildContext context}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOutExpo,
    width: menuOpen ? 450 : 100,
    height: MediaQuery.of(context).size.height,
    color: appbarColor,
    child: _sideMenuIcons(),
  );
}

Widget _sideMenuIcons() {
  return Column(
    children: [
      _sideMenuIcon(
        PageType.homepage,
        Icons.home_rounded,
        () {},
      ),
      _sideMenuIcon(
        PageType.anotherPage,
        Icons.home_rounded,
        () {},
      ),
    ],
  );
}

Widget _sideMenuIcon(PageType pageType, IconData icon, Function? onClick) {
  return Row(
    children: [
      SizedBox(
        width: 100,
        height: 100,
        child: MaterialButton(
          onPressed: () {},
          color: purple.withAlpha(page == pageType ? 200 : 100),
          splashColor: purple,
          hoverColor: purple.withAlpha(230),
          child: Icon(
            icon,
            color: textColor,
            size: 60,
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: purple.withAlpha(page == pageType ? 200 : 100),
          height: 100,
          alignment: Alignment.center,
          child: text(
            pageType.pageName,
            fontSize: 30,
          ),
        ),
      ),
    ],
  );
}
