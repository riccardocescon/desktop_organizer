import 'dart:io';

import 'package:desktop_organizer/pages/file_view.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/virtual_desktop_helper.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:desktop_organizer/widgets/side_bar.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
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
    return Stack(
      children: [
        Row(
          children: [
            sideMenu(
              context: context,
              onPageSelected: (pageSelected) {
                setState(() {
                  page = pageSelected;
                  if (page == PageType.realDesktop) {
                    //currentPage = realDekstop;
                  } else if (page == PageType.virtualDesktop) {
                    //currentPage = virtualDesktop;
                  }
                });
              },
            ),
            Expanded(
              child: Column(
                children: [
                  _topBar(),
                  Expanded(
                    child: _page(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.04,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: MaterialButton(
                onPressed: () async {
                  String? path = await FilesystemPicker.open(
                    title: 'Navigation Folder',
                    context: context,
                    rootDirectory: Directory(VirtualDesktopHelper().getRoot()),
                    fsType: FilesystemType.folder,
                    pickText: 'Select Folder',
                    folderIconColor: purple,
                  );
                  if (path == null) return;
                  setState(() {
                    //currentPage.currentDirectory = Directory(path);
                    //currentPage.items = scanFolder(path: path);
                  });
                },
                color: appbarColor.withAlpha(200),
                hoverColor: purple,
                splashColor: Colors.deepPurpleAccent,
                child: text(
                  "C:\\",
                  //currentPage.getRoot(),
                  color: textColor,
                  fontSize: 30,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _topBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      color: purple.withAlpha(150),
      child: Stack(
        children: [
          Visibility(
            visible: VirtualDesktopHelper().isOnRoot,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: textColor,
                size: 34,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  VirtualDesktopHelper().parentDirectory();
                });
              },
            ),
          ),
        ],
      ),
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
    return page == PageType.virtualDesktop
        ? FileView(
            onFolderChanged: _onFolderChanged,
          )
        : FileView(
            onFolderChanged: _onFolderChanged,
          );
  }

  void _onFolderChanged() {
    setState(() {});
  }
}
