import 'package:desktop_organizer/utils/enums.dart';

abstract class Item {
  String name;
  ItemType itemType;
  Item({required this.name, required this.itemType});
}
