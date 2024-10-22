import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/components/my_drawer_tile.dart';
import 'package:fooddeliveryapp/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // App logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          // Divider after logo
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // Home List Tile (to be implemented)
          MyDrawerTile(text: "H O M E", icon: Icons.home, onTap: () => Navigator.pop(context)),

          // Settings List Tile
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              ); // Navigate to SettingsPage
            },
          ),

          // Logout List Tile (to be implemented)
          MyDrawerTile(text: "L O G O U T", icon: Icons.logout, onTap: () {})
        ],
      ),
    );
  }
}
