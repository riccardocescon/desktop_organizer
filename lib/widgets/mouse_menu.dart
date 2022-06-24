import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/virtual_desktop_helper.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:flutter/material.dart';

Widget mouseMenu({required Function onEventCompleted}) {
  if (mousePosition == null) return Container();
  return Positioned(
    left: mousePosition!.dx - sideMenuLength - 40,
    top: mousePosition!.dy - 98,
    child: GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: mouseMenuAnimationTimeMS),
          curve: Curves.easeInOutExpo,
          width: mouseMenuWidth,
          height: mouseMenuOpen
              ? 50 *
                  _getMenu(onEventCompleted: onEventCompleted).length.toDouble()
              : 0,
          color: backgroundColor,
          child: Column(
            children: _getMenu(onEventCompleted: onEventCompleted),
          ),
        ),
      ),
    ),
  );
}

List<Widget> _emptyMenu({required Function onEventCompleted}) {
  return [
    _mouseMenuItem(
      Icons.create_new_folder_rounded,
      "Create Folder",
      onClick: () {
        // TODO _ request name and create folder
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test\\Marco\\Ciao");
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test2\\Marco\\Ciao");
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test\\Marco\\Proca");
        onEventCompleted.call();
      },
    ),
  ];
}

List<Widget> _filesMenu({required Function onEventCompleted}) {
  return [
    _mouseMenuItem(
      Icons.near_me_rounded,
      "Move To",
      onClick: () {},
    ),
    _mouseMenuItem(
      Icons.text_snippet_outlined,
      "Rename",
      onClick: () {},
    ),
    _mouseMenuItem(
      Icons.color_lens_rounded,
      "Set Color",
      onClick: () {},
    ),
    _mouseMenuItem(
      Icons.delete_rounded,
      "Delete",
      color: Colors.red.withAlpha(180),
      hoverColor: Colors.red,
      splashColor: Colors.redAccent,
      onClick: () {},
    ),
  ];
}

List<Widget> _folderMenu({required Function onEventCompleted}) {
  return [
    _mouseMenuItem(
      Icons.near_me_rounded,
      "Move To",
      onClick: () {},
    ),
    _mouseMenuItem(
      Icons.text_snippet_outlined,
      "Rename",
      onClick: () {
        VirtualDesktopHelper().renameItem(mouseItem!, "newName");
        onEventCompleted.call();
      },
    ),
    _mouseMenuItem(
      Icons.color_lens_rounded,
      "Set Color",
      onClick: () {},
    ),
    _mouseMenuItem(
      Icons.delete_rounded,
      "Deleted",
      color: Colors.red.withAlpha(180),
      hoverColor: Colors.red,
      splashColor: Colors.redAccent,
      onClick: () {
        VirtualDesktopHelper().removeDirectory(mouseItem!);
        onEventCompleted.call();
      },
    ),
  ];
}

List<Widget> _getMenu({required Function onEventCompleted}) {
  return mouseMenuType == MouseMenuType.emptySlot
      ? _emptyMenu(onEventCompleted: onEventCompleted)
      : mouseMenuType == MouseMenuType.file
          ? _filesMenu(onEventCompleted: onEventCompleted)
          : _folderMenu(onEventCompleted: onEventCompleted);
}

Widget _mouseMenuItem(
  IconData icon,
  String name, {
  required Function onClick,
  Color? color,
  Color? hoverColor,
  Color? splashColor,
}) {
  return Expanded(
    child: MaterialButton(
      onPressed: () {
        onClick.call();
      },
      color: color ?? backgroundColor,
      hoverColor: hoverColor ?? purple.withAlpha(180),
      splashColor: splashColor ?? purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 36,
          ),
          text(
            name,
            color: textColor,
          ),
        ],
      ),
    ),
  );
}
