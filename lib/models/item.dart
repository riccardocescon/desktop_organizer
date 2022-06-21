import 'package:desktop_organizer/utils/enums.dart';

abstract class Item {
  String name;
  ItemType itemType;
  Item? parent;
  Item({required this.name, required this.itemType, required this.parent});

  String getAbsolutePath() {
    if (parent == null) {
      return name;
    } else {
      return "${parent!.getAbsolutePath()}\\$name";
    }
  }
}
