import 'package:flutter/material.dart';
import '../menu_bar.dart';
import 'entry.dart';

class MenuStyle {
  /// Style the menus and submenus by implementing a custom [MenuStyle].
  const MenuStyle({
    this.width = 200.0,
    this.openSubmenusOnHover = true,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  final double width;
  final bool openSubmenusOnHover;
  final Color backgroundColor;
  final EdgeInsets padding;
}

class BarButton extends MenuBarEntryMenu {
  /// A [BarButton] is displayed as a button in the bar.
  ///
  /// The following 2 fields are necessary: [text] and [submenu].
  ///
  /// Assign a Text widget to the [text] field. This text is displayed as the button text, for example "File", "Edit", "Help", etc.
  ///
  /// Assign a SubMenu to the [submenu] field. This submenu is the menu that is opened on when tapping this button.
  ///
  /// You can style the [BarButton] widgets in the `barButtonStyle` field of your MenuBarWidget.
  const BarButton({
    super.key,
    required Widget text,
    required SubMenu submenu,
  }) : super(text: text, submenu: submenu, menuItems: null);
}

class MenuBarEntryMenu extends StatefulWidget {
  const MenuBarEntryMenu({
    Key? key,
    required this.text,
    required this.menuItems,
    required this.submenu,
    this.menuBarButtonStyle = const BarButtonStyle(),
    this.menuButtonStyle = const MenuButtonStyle(),
    this.closeOnHoverLeave = true,
    this.openMenusOnHover = false,
    this.openSubmenusOnHover = false,
    this.closeOnHoverDelay = const Duration(milliseconds: 400),
    this.width = 200,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  }) : super(key: key);

  final List<MenuEntry>? menuItems;
  final SubMenu? submenu;
  final Widget? text;
  final BarButtonStyle menuBarButtonStyle;
  final MenuButtonStyle menuButtonStyle;
  final bool closeOnHoverLeave;
  final bool openMenusOnHover;
  final bool openSubmenusOnHover;
  final Duration closeOnHoverDelay;
  final double width;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  State<MenuBarEntryMenu> createState() => _MenuBarMenuState();
}

class _MenuBarMenuState extends State<MenuBarEntryMenu> {
  final GlobalKey<_MenuBarMenuState> key = GlobalKey<_MenuBarMenuState>();
  double height = 0;
  OverlayEntry? _overlayEntry;
  bool visible = false;
  bool canClose = false;
  int submenuIndex = 0;
  final List<OverlayEntry?> _overlayEntrys = [];
  late FocusNode focusNode;
  List<int> tempSubMenuButtonIndeces = [];
  List<double?> dividerHeights = [];
  List<int> currentDividersAmounts = [];
  int heightMultiplier = 0;
  double dividerHeight = 0.0;

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  void openMenu({
    TapDownDetails? detailshenOpened,
    bool submenu = false,
    bool closeOnClick = true,
    required List<MenuEntry> menuItems,
    required double offsetX,
    required double offsetY,
  }) {
    if (_overlayEntrys.isEmpty || submenu) {
      _overlayEntry = _createOverlayEntry(
        menuItems: menuItems,
        offsetX: offsetX,
        offsetY: offsetY,
      );
      _overlayEntrys.add(_overlayEntry);

      Overlay.of(context).insert(_overlayEntry!);
      visible = true;
    } else {
      if (!closeOnClick) return;
      if (widget.openMenusOnHover) {
        canClose ? closeMenu() : canClose = true;
      } else {
        closeMenu();
      }
    }

    focusNode.requestFocus();
  }

  void closeMenu({Duration duration = const Duration(milliseconds: 0)}) async {
    visible = false;
    await Future.delayed(duration);
    if (!visible) {
      for (var i = 0; i < _overlayEntrys.length; i++) {
        _overlayEntrys[i]?.remove();
      }
      _overlayEntrys.clear();
      submenuIndex = 0;
      heightMultiplier = 0;
      dividerHeight = 0.0;
      tempSubMenuButtonIndeces.clear();
      dividerHeights.clear();
      currentDividersAmounts.clear();
    }
  }

  void closeSubmenus({
    required int finalIndex,
    required Function(int) setIndex,
  }) {
    var highestButtonIndex = submenuIndex;
    for (var j = submenuIndex; j > finalIndex; j--) {
      submenuIndex--;

      _overlayEntrys[j - 1]?.remove();
      _overlayEntrys.removeAt(j - 1);
    }

    for (var i = highestButtonIndex; i > submenuIndex; i--) {
      if (tempSubMenuButtonIndeces.isNotEmpty) {
        heightMultiplier -= tempSubMenuButtonIndeces[i - 2];
        tempSubMenuButtonIndeces.removeAt(i - 2);
      }
      if (dividerHeights.isNotEmpty) {
        dividerHeight -= dividerHeights[i - 2] ?? 0.0;
        dividerHeights.removeAt(i - 2);
      }
      if (currentDividersAmounts.isNotEmpty) {
        currentDividersAmounts.removeAt(i - 2);
      }
    }

    setIndex(0); //index = 0;
  }

  void openSubmenus({
    required int actualIndex,
    required MenuEntry menuItem,
    required List<MenuEntry> menuItems,
    required int index,
    required int finalSubmenuIndex,
    required Function(int) setIndex,
    required bool canClose,
    required Function(bool) setCanClose,
    required bool hover,
  }) {
    //if (!hover) finalIndex--;

    closeSubmenu() {
      closeSubmenus(
        finalIndex: finalSubmenuIndex,
        setIndex: setIndex,
      );
    }

    setIndex(index + submenuIndex); //index += buttonIndex;
    var newIndex = index + submenuIndex;
    if (newIndex > submenuIndex) {
      //index > buttonIndex
      if (widget.openSubmenusOnHover && !hover) {
        canClose ? closeSubmenu() : setCanClose(true);
      } else {
        closeSubmenu();
      }

      //if same, return. if not, let other open
      return;
    }

    double? currentDividerHeight;
    int currentDividersAmount = 0;
    for (var i = 0; i < menuItems.length; i++) {
      if (menuItems[i].divider == true) {
        if (actualIndex > i) {
          dividerHeight += menuItems[i].height ?? 0.0;
          currentDividerHeight ??= 0;
          currentDividerHeight += menuItems[i].height ?? 0.0;
          currentDividersAmount++;
        }
      }
    }

    currentDividersAmounts.add(currentDividersAmount);
    dividerHeights.add(currentDividerHeight);
    tempSubMenuButtonIndeces.add(actualIndex);
    var finalDividersAmount = 0;
    for (var i = 0; i < currentDividersAmounts.length; i++) {
      finalDividersAmount += currentDividersAmounts[i];
    }

    heightMultiplier += actualIndex;

    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    openMenu(
      submenu: true,
      closeOnClick: false,
      menuItems: menuItem.submenu!.menuItems!,
      offsetX: offset.dx + widget.width * _overlayEntrys.length,
      offsetY: height +
          widget.menuButtonStyle.height *
              (heightMultiplier - finalDividersAmount) +
          dividerHeight,
    );
  }

  OverlayEntry _createOverlayEntry({
    required List<MenuEntry> menuItems,
    required double offsetX,
    required double offsetY,
  }) {
    submenuIndex++;
    var finalSubmenuIndex = submenuIndex;
    var index = 0;
    var canClose = false;
    var submenuVisible = false;
    var tempIndex = 0;

    return OverlayEntry(
      builder: (_) => Positioned(
        left: offsetX,
        top: offsetY,
        child: MouseRegion(
          onEnter: (_) {
            visible = true;
            submenuVisible = true;
          },
          onExit: (_) {
            submenuVisible = true;

            if (!widget.closeOnHoverLeave) return;
            closeMenu(duration: widget.closeOnHoverDelay);
          },
          child: Focus(
            focusNode: focusNode,
            onFocusChange: (value) {
              if (!value) closeMenu();
            },
            child: Material(
              type: MaterialType.card,
              elevation: 2.0,
              color: widget.backgroundColor,
              child: Container(
                padding: widget.padding,
                width: widget.width,
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    var menuItem = menuItems[i];
                    if (menuItem.divider == true) {
                      return Divider(
                        height: menuItem.height,
                        thickness: menuItem.thickness,
                        indent: menuItem.indent,
                        endIndent: menuItem.endIndent,
                        color: menuItem.color,
                      );
                    }
                    openSubmenu({required bool hover}) {
                      openSubmenus(
                        actualIndex: i,
                        menuItem: menuItem,
                        menuItems: menuItems,
                        setIndex: (_) => index = _,
                        index: index,
                        finalSubmenuIndex: finalSubmenuIndex,
                        canClose: canClose,
                        setCanClose: (_) => canClose = _,
                        hover: hover,
                      );
                    }

                    return SizedBox(
                      height: widget.menuButtonStyle.height,
                      child: Material(
                        color: widget.menuButtonStyle.backgroundColor,
                        type: MaterialType.canvas,
                        child: InkWell(
                          onHover: (hover) async {
                            if (widget.openSubmenusOnHover) {
                              if (hover) {
                                if (menuItems[i].submenu != null) {
                                  openSubmenu(hover: true);

                                  var newIndex = index + submenuIndex;
                                  if (newIndex <= submenuIndex) {
                                    openSubmenu(hover: true);
                                  }

                                  canClose = false;
                                  submenuVisible = true;
                                } else {
                                  submenuVisible = false;

                                  await Future.delayed(
                                      widget.closeOnHoverDelay);
                                  if (!submenuVisible) {
                                    closeSubmenus(
                                      finalIndex: finalSubmenuIndex,
                                      setIndex: (_) => index = _,
                                    );
                                  }
                                }
                              }
                            }
                          },
                          onTap: menuItem.onTap != null
                              ? () {
                                  menuItem.onTap?.call();
                                  if (menuItem.submenu != null) {
                                    openSubmenu(hover: false);
                                    if (widget.openSubmenusOnHover) return;
                                    var newIndex = index + submenuIndex;
                                    if (newIndex <= submenuIndex) {
                                      if (tempIndex == i) return;
                                      openSubmenu(hover: true);
                                    }
                                    tempIndex = i;
                                  } else {
                                    if (widget
                                        .menuButtonStyle.closeMenuOnClick) {
                                      closeMenu();
                                    }
                                  }
                                }
                              : null,
                          child: Padding(
                            padding: widget.menuButtonStyle.padding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (menuItem.icon != null) menuItem.icon!,
                                    const SizedBox(width: 6.0),
                                    if (menuItem.text != null) menuItem.text!
                                  ],
                                ),
                                if (menuItem.shortcutText != null)
                                  Text(
                                    menuItem.shortcutText!.toString(),
                                    style: widget
                                        .menuButtonStyle.shortcutTextStyle,
                                  ),
                                if (menuItem.submenu != null &&
                                    widget.menuButtonStyle.showSubmenuIcon)
                                  widget.menuButtonStyle.submenuIcon,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: menuItems.length,
                  shrinkWrap: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDefaultMenu() {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    openMenu(
      menuItems: widget.submenu!.menuItems!,
      offsetX: offset.dx,
      offsetY: offset.dy + height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        height = constraints.maxHeight;
        return MouseRegion(
          onEnter: (_) {
            if (widget.openMenusOnHover) {
              showDefaultMenu();
              canClose = false;
            }
          },
          onExit: widget.closeOnHoverLeave
              ? (event) => closeMenu(duration: widget.closeOnHoverDelay)
              : null,
          child: Material(
            color: widget.menuBarButtonStyle.backgroundColor,
            type: MaterialType.card,
            child: InkWell(
              key: key,
              onTapDown: (_) => showDefaultMenu(),
              borderRadius: BorderRadius.circular(3),
              child: Center(
                child: Padding(
                  padding: widget.menuBarButtonStyle.padding,
                  child: widget.text,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
