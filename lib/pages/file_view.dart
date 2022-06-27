import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/virtual_desktop_helper.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:desktop_organizer/widgets/mouse_menu.dart';
import 'package:flutter/material.dart';

class FileView extends StatefulWidget {
  final Function onFolderChanged;

  const FileView({super.key, required this.onFolderChanged});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideMouseMenu();
      },
      child: Stack(
        children: [
          _itemsGrid(),
          mouseMenu(
            context: context,
            onEventCompleted: () {
              _hideMouseMenu();
              setState(() {});
            },
            onSetStateRequired: () {
              setState(() {});
            },
          ),
        ],
      ),
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

  Widget _gridViewItem(Item item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: _menuTapDetector(
        item: item,
        menuType: MouseMenuType.folder,
        child: SizedBox(
          width: 100,
          height: 100,
          child: MaterialButton(
            onPressed: () {
              _hideMouseMenu();
              if (item.itemType == ItemType.folder) {
                setState(() {
                  VirtualDesktopHelper().openDirectory(item.getAbsolutePath());
                  //widget.items =
                  //widget.fileViewData.items = scanFolder(path: item.path);
                  //widget.fileViewData.currentDirectory = Directory(item.path);
                  widget.onFolderChanged.call();
                });
              }
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

  void _hideMouseMenu() {
    setState(() {
      mouseMenuOpen = false;
    });
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
        item: null,
        menuType: MouseMenuType.emptySlot,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: VirtualDesktopHelper().getItems().length,
          itemBuilder: (itemContext, index) {
            return _gridViewItem(
              VirtualDesktopHelper().getItems()[index],
            );
          },
        ),
      ),
    );
  }

  Widget _menuTapDetector({
    required MouseMenuType menuType,
    required Widget child,
    required Item? item,
  }) {
    return GestureDetector(
      onSecondaryTap: () {
        _showMouseMenu(menuType: menuType);
        mouseItem = item;
      },
      onSecondaryTapDown: (details) {
        getPosition(details, menuType);
      },
      child: child,
    );
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
}
