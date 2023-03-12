import 'package:flutter/material.dart';
import '../menu_bar.dart';

class MenuEntry {
  const MenuEntry({
    required this.onTap,
    required this.text,
    this.submenu,
    this.shortcutText,
    this.icon,
    this.height,
    this.divider = false,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  final Function? onTap;
  final Widget? text;
  final SubMenu? submenu;
  final String? shortcutText;
  final Widget? icon;
  final double? height;
  final bool divider;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;
}
