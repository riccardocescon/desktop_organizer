import 'dart:developer';

import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/pages/file_view.dart';
import 'package:desktop_organizer/pages/scanner_view.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:desktop_organizer/widgets/mouse_menu.dart';
import 'package:desktop_organizer/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(
          "Homepage",
          fontSize: 30,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 50,
            color: purple,
          ),
          padding: const EdgeInsets.only(left: 10),
          splashRadius: 0.1,
          onPressed: () {
            setState(() {
              menuOpen = !menuOpen;
              sideMenuLength = menuOpen ? 450 : 100;
            });
          },
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Row(
      children: [
        sideMenu(
          context: context,
          onPageSelected: (pageSelected) {
            setState(() {
              page = pageSelected;
            });
          },
        ),
        Expanded(
          child: _page(),
        ),
      ],
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            padding: const EdgeInsets.all(40),
            color: appbarColor,
            child: _getPageView(),
          ),
        ),
      ),
    );
  }

  Widget _getPageView() {
    return page == PageType.scanner
        ? const ScannerView()
        : FileView(
            files: virtualDesktop,
          );
  }
}
