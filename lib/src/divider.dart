import 'entry.dart';

class MenuDivider extends MenuEntry {
  /// A [MenuDivider] is displayed as a Divider in the menus and submenus.
  ///
  /// All the fields correspond to a regular Divider widget. Assign the fields like you would for a Divider widget.
  const MenuDivider({
    double super.height = 12.0,
    super.thickness,
    super.indent,
    super.endIndent,
    super.color,
  }) : super(
         menuEntryType: MenuEntryType.menuDivider,
         text: null,
         icon: null,
         shortcut: null,
         shortcutText: null,
         onTap: null,
         submenu: null,
       );
}
