import 'package:flutter/material.dart';

import '../menu_bar.dart';
import 'entry.dart';

class BarButton extends MenuEntry {
  /// A [BarButton] is displayed as a button in the bar.
  ///
  /// The following 2 fields are necessary: [text] and [submenu].
  ///
  /// Assign a widget to the [text] field. This text is displayed as the button text, for example "File", "Edit", "Help", etc.
  ///
  /// Assign a SubMenu to the [submenu] field. This submenu is the menu that is opened on when tapping this button.
  ///
  /// You can style the [BarButton] widgets in the `barButtonStyle` field of your MenuBarWidget.
  const BarButton({
    required Widget text,
    required SubMenu submenu,
  }) : super(
          menuEntryType: MenuEntryType.BarButton,
          text: text,
          submenu: submenu,
        );
}

class MenuButton extends MenuEntry {
  /// A [MenuButton] is displayed as a button in the menus and submenus.
  ///
  /// The following field is necessary: [text].
  ///
  /// Assign a Text widget to the [text] field. This text is displayed as the button text. You can also wrap your assigned Text around a Padding widget.
  ///
  /// **Optional fields**
  ///
  /// To open a submenu on press, assign a SubMenu widget to the [submenu] field. **IMPORTANT**: The [onTap] field has to be `null` if [submenu] is set.
  ///
  /// To display a leading icon, assign an Icon widget to the [icon] field.
  ///
  /// To trigger the [onTap] with a keyboard shortcut, assign a `MenuSerializableShortcut` to the [shortcut] field. For example: `SingleActivator(LogicalKeyboardKey.keyS, control: true)`
  ///
  /// To display a trailing shortcut text, assign a String to the [shortcutText] field. You can style this text in the `shortcutTextStyle` field.
  ///
  /// You can style the [MenuButton] widgets in the `menuButtonStyle` field of your MenuBarWidget.
  const MenuButton({
    required Widget text,
    super.onTap,
    super.submenu,
    super.icon,
    super.shortcut,
    super.shortcutText,
    TextStyle shortcutStyle =
        const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
  }) : super(
            menuEntryType: MenuEntryType.MenuButton,
            text: text,
            shortcutStyle: shortcutStyle);
}
