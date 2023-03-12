import 'package:flutter/material.dart';
import 'entry.dart';

class MenuButtonStyle {
  /// Style the menu and submenu buttons by implementing a custom [MenuButtonStyle].
  const MenuButtonStyle({
    this.closeMenuOnClick = true,
    this.backgroundColor = Colors.white,
    this.height = 28.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.shortcutTextStyle =
        const TextStyle(fontSize: 15.0, color: Colors.grey),
    this.showSubmenuIcon = true,
    this.submenuIcon = const Icon(Icons.keyboard_arrow_right),
  });

  final bool closeMenuOnClick;
  final Color backgroundColor;
  final double height;
  final EdgeInsets padding;
  final TextStyle shortcutTextStyle;
  final bool showSubmenuIcon;
  final Widget submenuIcon;
}

class MenuButton extends MenuEntry {
  /// A [MenuButton] is displayed as a button in the menus and submenus.
  ///
  /// The following 2 fields are necessary: [onTap] and [text].
  ///
  /// Assign a Function to the [onTap] field. This function will be executed when pressing the button. Set to `null` to disable the button. Though keep in mind to implement a custom solution for disabled colors in case you want disabled colors.
  ///
  /// Assign a Text widget to the [text] field. This text is displayed as the button text. You can also wrap your assigned Text around a Padding widget.
  ///
  /// **Optional fields**
  ///
  /// To open a submenu on press, assign a SubMenu widget to the [submenu] field. You can now set the [onTap] field to an empty function `() {}` if you don't want to execute a function when opening and closing the submenu.
  ///
  /// To display a leading icon, assign an Icon widget to the [icon] field.
  ///
  /// To display a trailing shortcut text, assign a String to the [shortcutText] field. This is just a text, not a Shortcut system. You can style this text in the `menuButtonStyle` of your MenuBar widget (field: `shortcutTextStyle`).
  ///
  /// You can style the [MenuButton] widgets in the `menuButtonStyle` field of your MenuBar widget.
  const MenuButton({
    /// Assign a Text widget to the [text] field. This text is displayed as the button text. You can also wrap your assigned Text around a Padding widget.
    required super.onTap,
    required Widget text,
    super.icon,
    super.shortcutText,
    super.submenu,
  }) : super(text: text);
}
