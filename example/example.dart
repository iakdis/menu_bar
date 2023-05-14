import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_bar/menu_bar.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BarButton> _menuBarButtons() {
    return [
      BarButton(
        text: const Text(
          'File',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () => print('Save'),
              text: const Text('Save'),
              shortcutText: 'Ctrl+S',
              shortcut:
                  const SingleActivator(LogicalKeyboardKey.keyS, control: true),
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Save as'),
              shortcutText: 'Ctrl+Shift+S',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('Open File'),
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Open Folder'),
            ),
            const MenuDivider(),
            MenuButton(
              text: const Text('Preferences'),
              icon: const Icon(Icons.settings),
              submenu: SubMenu(
                menuItems: [
                  MenuButton(
                    onTap: () {},
                    icon: const Icon(Icons.keyboard),
                    text: const Text('Shortcuts'),
                  ),
                  const MenuDivider(),
                  MenuButton(
                    onTap: () {},
                    icon: const Icon(Icons.extension),
                    text: const Text('Extensions'),
                  ),
                  const MenuDivider(),
                  MenuButton(
                    icon: const Icon(Icons.looks),
                    text: const Text('Change theme'),
                    submenu: SubMenu(
                      menuItems: [
                        MenuButton(
                          onTap: () {},
                          icon: const Icon(Icons.light_mode),
                          text: const Text('Light theme'),
                        ),
                        const MenuDivider(),
                        MenuButton(
                          onTap: () {},
                          icon: const Icon(Icons.dark_mode),
                          text: const Text('Dark theme'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              shortcutText: 'Ctrl+Q',
              text: const Text('Exit'),
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () {},
              text: const Text('Undo'),
              shortcutText: 'Ctrl+Z',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Redo'),
              shortcutText: 'Ctrl+Y',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('Cut'),
              shortcutText: 'Ctrl+X',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Copy'),
              shortcutText: 'Ctrl+C',
            ),
            MenuButton(
              onTap: () {},
              text: const Text('Paste'),
              shortcutText: 'Ctrl+V',
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('Find'),
              shortcutText: 'Ctrl+F',
            ),
          ],
        ),
      ),
      BarButton(
        text: const Text(
          'Help',
          style: TextStyle(color: Colors.white),
        ),
        submenu: SubMenu(
          menuItems: [
            MenuButton(
              onTap: () {},
              text: const Text('Check for updates'),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              text: const Text('View License'),
            ),
            const MenuDivider(),
            MenuButton(
              onTap: () {},
              icon: const Icon(Icons.info),
              text: const Text('About'),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Style the menus. Hover over [MenuStyle] for all the options
      theme: ThemeData(
        menuTheme: const MenuThemeData(
          style: MenuStyle(
            padding:
                MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16.0)),
          ),
        ),
      ),

      home: MenuBarWidget(
        // Add a list of [BarButton]. The buttons in this List are
        // displayed as the buttons on the bar itself
        barButtons: _menuBarButtons(),

        // Style the menu bar itself. Hover over [MenuStyle] for all the options
        barStyle: const MenuStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          backgroundColor: MaterialStatePropertyAll(Color(0xFF2b2b2b)),
          maximumSize: MaterialStatePropertyAll(Size(double.infinity, 28.0)),
        ),

        // Style the menu bar buttons. Hover over [ButtonStyle] for all the options
        barButtonStyle: const ButtonStyle(
          padding:
              MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 6.0)),
          minimumSize: MaterialStatePropertyAll(Size(0.0, 32.0)),
        ),

        // Style the menu and submenu buttons. Hover over [ButtonStyle] for all the options
        menuButtonStyle: const ButtonStyle(
          minimumSize: MaterialStatePropertyAll(Size.fromHeight(36.0)),
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0)),
        ),

        // Enable or disable the bar
        enabled: true,

        // Set the child, i.e. the application under the menu bar
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Menu Bar Example'),
          ),
          body: const Center(
            child: Text(
              'My application',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
