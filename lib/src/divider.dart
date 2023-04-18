import 'package:flutter/material.dart';
import 'entry.dart';

class MenuDivider extends MenuEntry {
  /// A [MenuDivider] is displayed as a Divider in the menus and submenus.
  ///
  /// All the fields correspond to a regular Divider widget. Assign the fields like you would for a Divider widget.
  const MenuDivider({
    double height = 12.0,
    double? thickness,
    double? indent,
    double? endIndent,
    Color? color,
  }) : super(
          menuEntryType: MenuEntryType.menuDivider,
          height: height,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
          color: color,
          text: null,
          icon: null,
          shortcut: null,
          shortcutText: null,
          onTap: null,
          submenu: null,
        );
}
