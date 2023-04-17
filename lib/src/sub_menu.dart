import 'entry.dart';

class SubMenu {
  /// A [SubMenu] is displayed as a submenu with the [menuItems] field as its items.
  ///
  /// Assign a List of either [MenuButton] or [MenuDivider] widgets to the [menuItems] field. The List should contain at least one item.
  const SubMenu({required this.menuItems}) : super();

  final List<MenuEntry> menuItems;
}
