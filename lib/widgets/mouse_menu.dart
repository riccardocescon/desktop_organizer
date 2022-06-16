import 'package:desktoop_organizer/utils/globals.dart';
import 'package:desktoop_organizer/utils/style.dart';
import 'package:desktoop_organizer/utils/widgets.dart';
import 'package:flutter/material.dart';

Widget mouseMenu() {
  if (mousePosition == null) return Container();
  return Positioned(
    left: mousePosition!.dx - sideMenuLength - 40,
    top: mousePosition!.dy - 98,
    child: GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutExpo,
          width: mouseMenuWidth,
          height: mouseMenuOpen ? 50 * 4 : 0,
          color: backgroundColor,
          child: Column(
            children: [
              _mouseMenuItem(
                Icons.near_me_rounded,
                "Move To",
              ),
              _mouseMenuItem(
                Icons.text_snippet_outlined,
                "Rename",
              ),
              _mouseMenuItem(
                Icons.color_lens_rounded,
                "Set Color",
              ),
              _mouseMenuItem(
                Icons.delete_rounded,
                "Delete",
                color: Colors.red.withAlpha(180),
                hoverColor: Colors.red,
                splashColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _mouseMenuItem(
  IconData icon,
  String name, {
  Color? color,
  Color? hoverColor,
  Color? splashColor,
}) {
  return Expanded(
    child: MaterialButton(
      onPressed: () {},
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
