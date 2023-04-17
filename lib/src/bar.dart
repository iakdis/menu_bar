import 'package:flutter/material.dart';
import '../menu_bar.dart';
import 'entry.dart';

class MenuBarWidget extends StatefulWidget {
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
  /// Menu and submenu buttons: Implement your custom [menuButtonStyle].

  const MenuBarWidget({
    super.key,
    required this.child,
    required this.barButtons,
    this.barStyle = const MenuStyle(),
    this.barButtonStyle = const ButtonStyle(),
    this.menuButtonStyle = const ButtonStyle(),
    this.enabled = true,
  });

  /// The [MenuBarWidget] contains a [child], i.e. your application under the [MenuBarWidget].
  final Widget child;

  /// Style the menu bar itself by implementing a custom [MenuStyle].
  final MenuStyle barStyle;

  /// Style the menu bar buttons by implementing a custom [ButtonStyle].
  final ButtonStyle barButtonStyle;

  /// List of [BarButton]. The buttons in this List are displayed as the buttons on the bar itself.
  final List<BarButton> barButtons;

  /// Style the menu and submenu buttons by implementing a custom [ButtonStyle].
  final ButtonStyle menuButtonStyle;

  /// If [enabled] is set to `true`, the menu bar is visible. Otherwise it is hidden while the [child] remains visible.
  final bool enabled;

  @override
  State<MenuBarWidget> createState() => _MenuBarWidgetState();
}

class _MenuBarWidgetState extends State<MenuBarWidget> {
  ShortcutRegistryEntry? _shortcutsEntry;

  List<BarButton> _entries() {
    _shortcutsEntry?.dispose();
    if (MenuEntry.shortcuts(widget.barButtons).isNotEmpty) {
      _shortcutsEntry = ShortcutRegistry.of(context)
          .addAll(MenuEntry.shortcuts(widget.barButtons));
    }

    return widget.barButtons;
  }

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (widget.enabled)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: MenuBar(
                  style: widget.barStyle,
                  children: MenuEntry.build(
                    entries: _entries(),
                    barButtonStyle: widget.barButtonStyle,
                    menuButtonStyle: widget.menuButtonStyle,
                  ),
                ),
              ),
            ],
          ),
        Expanded(child: widget.child),
      ],
    );
  }
}
