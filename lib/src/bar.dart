import 'package:flutter/material.dart' hide MenuStyle;
import '../menu_bar.dart';

class BarStyle {
  /// Style the menu bar itself by implementing a custom [BarStyle].
  const BarStyle({
    this.height = 28.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.backgroundColor = const Color(0xFF424242),
    this.gap = 0.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
    this.closeMenuOnHoverLeave = true,
    this.openMenuOnHover = false,
    this.closeMenuOnHoverDelay = const Duration(milliseconds: 400),
  });

  final double height;
  final MainAxisAlignment mainAxisAlignment;
  final Color backgroundColor;
  final double gap;
  final EdgeInsets padding;
  final bool closeMenuOnHoverLeave;
  final bool openMenuOnHover;
  final Duration closeMenuOnHoverDelay;
}

class BarButtonStyle {
  /// Style the menu bar buttons by implementing a custom [BarButtonStyle].
  const BarButtonStyle({
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0),
  });

  final Color backgroundColor;
  final EdgeInsets padding;
}

class MenuBarWidget extends StatelessWidget {
  /// Hover over each field for more details.
  ///
  /// **Create the [MenuBarWidget]:**
  ///
  /// The following 2 fields are necessary: [child] and [barButtons].
  ///
  /// The [MenuBarWidget] contains a [child], i.e. your application under the [MenuBarWidget].
  /// For the [barButtons] field, implement a List of [BarButton]. The buttons in this List are displayed as the buttons on the bar.
  ///
  /// **Style the [MenuBarWidget]:**
  ///
  /// The bar itself: Implement your custom [barStyle].
  ///
  /// Bar buttons: Implement your custom [barButtonStyle].
  ///
  /// The menu and submenu itself: Implement your custom [menuStyle].
  ///
  /// Menu and submenu buttons: Implement your custom [menuButtonStyle].

  const MenuBarWidget({
    super.key,
    required this.child,
    required this.barButtons,
    this.barStyle = const BarStyle(),
    this.barButtonStyle = const BarButtonStyle(),
    this.menuStyle = const MenuStyle(),
    this.menuButtonStyle = const MenuButtonStyle(),
    this.enabled = true,
  });

  /// The [MenuBarWidget] contains a [child], i.e. your application under the [MenuBarWidget].
  final Widget child;

  /// List of [BarButton]. The buttons in this List are displayed as the buttons on the bar itself.
  final List<BarButton> barButtons;

  /// Style the menu bar itself by implementing a custom [BarStyle].
  final BarStyle barStyle;

  /// Style the menu bar buttons by implementing a custom [BarButtonStyle].
  final BarButtonStyle barButtonStyle;

  /// Style the menus and submenus by implementing a custom [MenuStyle].
  final MenuStyle menuStyle;

  /// Style the menu and submenu buttons by implementing a custom [MenuButtonStyle].
  final MenuButtonStyle menuButtonStyle;

  /// If [enabled] is set to `true`, the menu bar is visible. Otherwise it is hidden while the [child] remains visible.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (enabled)
          Container(
            color: barStyle.backgroundColor,
            height: barStyle.height,
            child: Padding(
              padding: barStyle.padding,
              child: Row(
                mainAxisAlignment: barStyle.mainAxisAlignment,
                children: [
                  for (var index = 0; index < barButtons.length; index++)
                    Row(
                      children: [
                        MenuBarEntryMenu(
                          submenu: SubMenu(
                              menuItems: barButtons[index].submenu!.menuItems!),
                          menuItems: barButtons[index].menuItems,
                          text: barButtons[index].text,
                          menuButtonStyle: menuButtonStyle,
                          openMenusOnHover: barStyle.openMenuOnHover,
                          closeOnHoverLeave: barStyle.closeMenuOnHoverLeave,
                          closeOnHoverDelay: barStyle.closeMenuOnHoverDelay,
                          width: menuStyle.width,
                          openSubmenusOnHover: menuStyle.openSubmenusOnHover,
                          backgroundColor: menuStyle.backgroundColor,
                          padding: menuStyle.padding,
                          menuBarButtonStyle: barButtonStyle,
                        ),
                        if (index < barButtons.length - 1)
                          SizedBox(width: barStyle.gap),
                      ],
                    ),
                ],
              ),
            ),
          ),
        Expanded(child: child),
      ],
    );
  }
}
