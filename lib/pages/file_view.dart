import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:desktop_organizer/widgets/mouse_menu.dart';
import 'package:flutter/material.dart';

class FileView extends StatefulWidget {
  FileView({super.key, required this.files});

  List<ScannedItem> files;

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
          mouseMenu(),
        ],
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
          itemCount: widget.files.length,
          itemBuilder: (itemContext, index) {
            return _gridViewItem(
              widget.files[index],
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
