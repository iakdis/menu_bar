## 0.5.0

- BREAKING: Renamed class `MenuBar` to `MenuBarWidget`. Now you don't need to write `import 'package:flutter/material.dart' hide MenuBar hide MenuStyle` in your Material package import
- BREAKING: Removed class `BarStyle` to style the bar itself; use class `MenuStyle` from Flutter instead
- BREAKING: Removed class `BarButtonStyle` to style the bar buttons; use class `ButtonStyle` from Flutter instead
- BREAKING: Removed class `MenuButtonStyle` to style the menu/submenu buttons; use class `ButtonStyle` from Flutter instead
- BREAKING: Removed custom class `MenuStyle` to style the menus/submenus

- Shortcuts are now supported in a `MenuButton`. For example: `shortcut: const SingleActivator(LogicalKeyboardKey.keyS, control: true),`
- Rewrite to use the native `MenuBar`, `MenuStyle` and `ButtonStyle` from Flutter

## 0.4.1

- Update README

## 0.4.0

- Fix breaking: Conflict between MenuBar and MenuStyle in material package

## 0.3.1

- Update: README.md for contact info

## 0.3.0

- Change: Menu bar button onTap to onTapDown

## 0.2.1

- Fix: Docs using old widget names

## 0.2.0

- Rename: BarMenuButton to BarButton
- Rename: MenuBarSubMenu to SubMenu
- Update: README.md

## 0.1.1

- Update screenshots

## 0.1.0

- Initial version.
