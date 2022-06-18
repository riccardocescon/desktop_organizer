import 'dart:developer';

import 'package:desktop_organizer/models/scanned_item.dart';
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
  List<ScannedItem> files = [
    ScannedItem(
      name: "School",
      itemType: ItemType.folder,
    ),
    ScannedItem(
      name: "es32.txt",
      itemType: ItemType.file,
    ),
  ];

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
        sideMenu(context: context),
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
            child: GestureDetector(
              onTap: () {
                _hideMouseMenu();
              },
              child: Stack(
                children: [
                  _itemsGrid(),
                  mouseMenu(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemsGrid() {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          _hideMouseMenu();
        }
        return true;
      },
      child: _menuTapDetector(
        menuType: MouseMenuType.emptySlot,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: files.length,
          itemBuilder: (itemContext, index) {
            return _gridViewItem(
              files[index],
            );
          },
        ),
      ),
    );
  }

  Widget _gridViewItem(ScannedItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: _menuTapDetector(
        menuType: MouseMenuType.file,
        child: SizedBox(
          width: 100,
          height: 100,
          child: MaterialButton(
            onPressed: () {
              _hideMouseMenu();
            },
            color: purple.withAlpha(100),
            hoverColor: purple.withAlpha(130),
            splashColor: purple.withAlpha(200),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  item.itemType == ItemType.folder
                      ? Icons.folder_rounded
                      : Icons.file_present_rounded,
                  color: textColor,
                  size: 80,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: text(
                      item.name,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuTapDetector(
      {required MouseMenuType menuType, required Widget child}) {
    return GestureDetector(
      onSecondaryTap: () {
        _showMouseMenu(menuType: menuType);
      },
      onSecondaryTapDown: (details) {
        getPosition(details, menuType);
      },
      child: child,
    );
  }

  void getPosition(TapDownDetails detail, MouseMenuType menuType) async {
    await Future.delayed(
      const Duration(
        milliseconds: mouseMenuAnimationTimeMS,
      ),
    );
    mousePosition = detail.globalPosition;
  }

  void _showMouseMenu({required MouseMenuType menuType}) async {
    _hideMouseMenu();
    await Future.delayed(
      const Duration(
        milliseconds: mouseMenuAnimationTimeMS,
      ),
    );
    setState(() {
      mouseMenuType = menuType;
      mouseMenuOpen = true;
    });
  }

  void _hideMouseMenu() {
    setState(() {
      mouseMenuOpen = false;
    });
  }
}
