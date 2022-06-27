import 'package:desktop_organizer/models/item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:desktop_organizer/utils/globals.dart';
import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/virtual_desktop_helper.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:flutter/material.dart';

List<SidedMouseMenu> _sideMenuWidgets = [];

void clearSideMenuFromDepth(int depth) {
  _sideMenuWidgets.removeWhere((widget) => widget.depth >= depth);
}

SidedMouseMenu? getSidedMouseMenuWithItem(int depth, Item? item) {
  if (item == null) return null;
  Iterable<SidedMouseMenu> values =
      _sideMenuWidgets.where((element) => element.depth == depth);
  for (SidedMouseMenu current in values) {
    for (Item currentItem in current.items) {
      if (currentItem.name == item.name) {
        return current;
      }
    }
  }
  return null;
}

Widget mouseMenu({
  required Function onEventCompleted,
  required Function onSetStateRequired,
  required BuildContext context,
}) {
  if (!mouseMenuOpen) {
    _sideMenuWidgets.clear();
    onSetStateRequired.call();
  }
  if (mousePosition == null) {
    return Container();
  }
  return Stack(
    children: [
      Positioned(
        left: mousePosition!.dx - sideMenuLength - 40,
        top: mousePosition!.dy - 150,
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
                      _getMenu(
                              onEventCompleted: onEventCompleted,
                              onSetStateRequired: onSetStateRequired,
                              context: context)
                          .length
                          .toDouble()
                  : 0,
              color: backgroundColor,
              child: Column(
                children: _getMenu(
                  onEventCompleted: onEventCompleted,
                  onSetStateRequired: onSetStateRequired,
                  context: context,
                ),
              ),
            ),
          ),
        ),
      ),
      for (SidedMouseMenu current in _sideMenuWidgets)
        Positioned(
          left: mousePosition!.dx -
              sideMenuLength -
              40 +
              (mouseMenuWidth * (current.depth + 1)),
          top: mousePosition!.dy - 150,
          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: mouseMenuAnimationTimeMS ~/ 3),
            curve: Curves.easeInOutExpo,
            width: _sideMenuWidgets.isNotEmpty ? mouseMenuWidth : 0,
            height: _sideMenuWidgets.isNotEmpty
                ? 50 * current.items.length.toDouble()
                : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: current.items
                    .map((e) =>
                        _sideMenuItem(e, onSetStateRequired, onEventCompleted))
                    .toList(),
              ),
            ),
          ),
        ),
    ],
  );
}

List<Widget> _emptyMenu({
  required Function onEventCompleted,
  required Function onSetStateRequired,
  required BuildContext context,
}) {
  return [
    _mouseMenuItem(
      Icons.create_new_folder_rounded,
      "Create Folder",
      onClick: () {
        // TODO _ request name and create folder
        _showFolderNameInput(
          context: context,
          onFolderCreated: () {
            onEventCompleted.call();
          },
        );
        /*
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test\\Marco\\Ciao");
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test2\\Giovanni\\Ciao");
        VirtualDesktopHelper().addDirectory(
            "${VirtualDesktopHelper().getRoot()}\\Test\\Marco\\Proca");
            */
      },
      onSetStateRequired: onSetStateRequired,
    ),
  ];
}

List<Widget> _filesMenu({
  required Function onEventCompleted,
  required Function onSetStateRequired,
}) {
  return [
    _mouseMenuItem(
      Icons.near_me_rounded,
      "Move To",
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
    ),
    _mouseMenuItem(
      Icons.text_snippet_outlined,
      "Rename",
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
    ),
    _mouseMenuItem(
      Icons.color_lens_rounded,
      "Set Color",
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
    ),
    _mouseMenuItem(
      Icons.delete_rounded,
      "Delete",
      color: Colors.red.withAlpha(180),
      hoverColor: Colors.red,
      splashColor: Colors.redAccent,
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
    ),
  ];
}

List<Widget> _folderMenu({
  required Function onEventCompleted,
  required Function onSetStateRequired,
}) {
  return [
    _mouseMenuItem(
      Icons.near_me_rounded,
      "Move To >",
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
      sidedFolder: true,
    ),
    _mouseMenuItem(
      Icons.text_snippet_outlined,
      "Rename",
      onClick: () {
        VirtualDesktopHelper().renameItem(mouseItem!, "newName");
        onEventCompleted.call();
      },
      onSetStateRequired: onSetStateRequired,
    ),
    _mouseMenuItem(
      Icons.color_lens_rounded,
      "Set Color",
      onClick: () {},
      onSetStateRequired: onSetStateRequired,
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
      onSetStateRequired: onSetStateRequired,
    ),
  ];
}

List<Widget> _getMenu({
  required Function onEventCompleted,
  required Function onSetStateRequired,
  required BuildContext context,
}) {
  return mouseMenuType == MouseMenuType.emptySlot
      ? _emptyMenu(
          onEventCompleted: onEventCompleted,
          onSetStateRequired: onSetStateRequired,
          context: context,
        )
      : mouseMenuType == MouseMenuType.file
          ? _filesMenu(
              onEventCompleted: onEventCompleted,
              onSetStateRequired: onSetStateRequired,
            )
          : _folderMenu(
              onEventCompleted: onEventCompleted,
              onSetStateRequired: onSetStateRequired,
            );
}

Widget _mouseMenuItem(
  IconData icon,
  String name, {
  required Function onClick,
  required Function onSetStateRequired,
  Color? color,
  Color? hoverColor,
  Color? splashColor,
  bool sidedFolder = false,
}) {
  return Expanded(
    child: MouseRegion(
      onEnter: (event) {
        if (sidedFolder) {
          List<Item> items =
              VirtualDesktopHelper().mouseMenuOpenDirectoryAndGetItems(
            VirtualDesktopHelper().getRoot(),
          );
          if (items.isEmpty) {
            return;
          }

          int selectedDepth = items.first.getDepth() - 1;

          clearSideMenuFromDepth(selectedDepth);

          _sideMenuWidgets.add(
            SidedMouseMenu(
              depth: selectedDepth,
              items: items,
              parent: null,
            ),
          );
          onSetStateRequired.call();
        }
      },
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
    ),
  );
}

void _showFolderNameInput({
  required BuildContext context,
  required Function onFolderCreated,
}) {
  TextEditingController nameController = TextEditingController();
  Widget dialog = AlertDialog(
    title: Text(
      "Folder Name",
      style: TextStyle(
        color: textColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: backgroundColor,
    actionsPadding: const EdgeInsets.all(20),
    actions: [
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: TextFormField(
            controller: nameController,
            cursorColor: purple,
            style: TextStyle(
              color: textColor,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: textColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: AspectRatio(
            aspectRatio: 6,
            child: MaterialButton(
              onPressed: () {
                String folderName = nameController.text;
                if (folderName.isEmpty) {
                  folderName = "New Folder";
                }
                VirtualDesktopHelper().addDirectory(
                  "${VirtualDesktopHelper().getCurrentDirectoryPath()}\\$folderName",
                );
                onFolderCreated.call();
                Navigator.pop(context);
              },
              color: purple,
              splashColor: Colors.deepPurpleAccent,
              child: Text(
                "Create",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (context) => dialog,
  );
}

Widget _sideMenuItem(
  Item item,
  Function onSetState,
  Function onEventCompleted,
) {
  if (item.getAbsolutePath() == mouseItem!.getAbsolutePath()) {
    return Container();
  }
  return SizedBox(
    width: mouseMenuWidth,
    height: 50,
    child: MouseRegion(
      onEnter: (event) {
        List<Item> items = VirtualDesktopHelper()
            .mouseMenuOpenDirectoryAndGetItems(item.getAbsolutePath());
        if (items.isEmpty) return;

        int selectedDepth = items.first.getDepth() - 1;

        clearSideMenuFromDepth(selectedDepth);

        _sideMenuWidgets.add(
          SidedMouseMenu(
            depth: selectedDepth,
            items: items,
            parent: item,
          ),
        );
        onSetState.call();
      },
      child: MaterialButton(
        color: purple.withAlpha(100),
        hoverColor: purple,
        splashColor: Colors.deepPurpleAccent,
        child: text(item.name, color: Colors.white),
        onPressed: () {
          String newPath = "${item.getAbsolutePath()}\\${mouseItem!.name}";
          VirtualDesktopHelper().moveFilStructureWithChildrenToNewPath(
              mouseItem!.getAbsolutePath(), newPath);
          onEventCompleted.call();
        },
      ),
    ),
  );
}

class SidedMouseMenu {
  int depth;
  List<Item> items;
  Item? parent;
  SidedMouseMenu({
    required this.depth,
    required this.items,
    required this.parent,
  });
}
