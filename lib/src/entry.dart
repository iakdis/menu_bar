import 'package:flutter/material.dart';
import '../menu_bar.dart';

enum MenuEntryType {
  barButton,
  menuButton,
  menuDivider,
}

class MenuEntry {
  const MenuEntry({
    required this.text,
    required this.menuEntryType,
    this.icon,
    this.shortcut,
    this.shortcutText,
    this.shortcutStyle,
    this.onTap,
    this.submenu,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : assert(submenu == null || onTap == null,
            'onTap is ignored if submenu is provided');
  final MenuEntryType menuEntryType;
  final Widget? text;
  final Widget? icon;
  final MenuSerializableShortcut? shortcut;
  final String? shortcutText;
  final TextStyle? shortcutStyle;
  final VoidCallback? onTap;
  final SubMenu? submenu;
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  static List<Widget> build({
    required List<MenuEntry> entries,
    required ButtonStyle barButtonStyle,
    required ButtonStyle menuButtonStyle,
  }) {
    Widget buildSelection(MenuEntry entries) {
      if (entries.menuEntryType == MenuEntryType.menuDivider) {
        return Divider(
          height: entries.height,
          thickness: entries.thickness,
          indent: entries.indent,
          endIndent: entries.endIndent,
          color: entries.color,
        );
      }

      if (entries.submenu != null) {
        return SubmenuButton(
          style: entries.menuEntryType == MenuEntryType.barButton
              ? barButtonStyle
              : menuButtonStyle,
          leadingIcon: entries.icon,
          menuChildren: MenuEntry.build(
            entries: entries.submenu!.menuItems,
            barButtonStyle: barButtonStyle,
            menuButtonStyle: menuButtonStyle,
          ),
          child: entries.text,
        );
      }
      return MenuItemButton(
        style: menuButtonStyle,
        leadingIcon: entries.icon,
        trailingIcon: entries.shortcutText != null
            ? Text(entries.shortcutText!, style: entries.shortcutStyle)
            : null,
        onPressed: entries.onTap,
        child: entries.text,
      );
    }

    return entries.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.submenu != null) {
        result.addAll(MenuEntry.shortcuts(selection.submenu!.menuItems));
      } else {
        if (selection.shortcut != null && selection.onTap != null) {
          result[selection.shortcut!] = VoidCallbackIntent(selection.onTap!);
        }
      }
    }
    return result;
  }
}
