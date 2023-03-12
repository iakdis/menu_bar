import 'entry.dart';
import 'menu.dart';

class SubMenu extends MenuBarEntryMenu {
  /// A [SubMenu] is displayed as a submenu with the [menuItems] field as its items.
  ///
  /// The following field is necessary: [menuItems].
  ///
  /// Assign a List of either [MenuButton] or [MenuDivider] widgets to the [menuItems] field. The List should contain at least one item.
  ///
  /// You can style the [SubMenu] widgets in the `menuStyle` field of your MenuBar widget.
  const SubMenu({
    super.key,
    required List<MenuEntry> menuItems,
  }) : super(menuItems: menuItems, text: null, submenu: null);
}
