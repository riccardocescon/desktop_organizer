import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:flutter/material.dart';

const double _maxHeight = 80;

Widget sideMenu({required BuildContext context}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOutExpo,
    width: menuOpen ? _maxHeight * 4 : _maxHeight,
    height: MediaQuery.of(context).size.height,
    color: appbarColor,
    child: _sideMenuIcons(context),
  );
}

Widget _sideMenuIcons(context) {
  return Column(
    children: [
      _sideMenuIcon(
        PageType.scanner,
        Icons.perm_scan_wifi,
        () {},
        context: context,
      ),
      _sideMenuIcon(
        PageType.virtualDesktop,
        Icons.home_rounded,
        () {},
        context: context,
      ),
      _sideMenuIcon(
        PageType.realDesktop,
        Icons.real_estate_agent,
        () {},
        context: context,
      ),
      _sideMenuIcon(
        PageType.typesDesktop,
        Icons.file_copy_sharp,
        () {},
        context: context,
      ),
    ],
  );
}

Widget _sideMenuIcon(
  PageType pageType,
  IconData icon,
  Function? onClick, {
  required BuildContext context,
}) {
  return Row(
    children: [
      Expanded(
        child: LimitedBox(
          maxHeight: _maxHeight,
          child: AspectRatio(
            aspectRatio: 1,
            child: Row(
              children: [
                LimitedBox(
                  maxWidth: _maxHeight,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: MaterialButton(
                      onPressed: () {},
                      color: purple.withAlpha(page == pageType ? 200 : 100),
                      splashColor: purple,
                      hoverColor: purple.withAlpha(230),
                      padding: EdgeInsets.zero,
                      child: Icon(
                        icon,
                        color: textColor,
                        size: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: purple.withAlpha(page == pageType ? 200 : 100),
                    height: _maxHeight,
                    alignment: Alignment.center,
                    child: text(
                      pageType.pageName,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
