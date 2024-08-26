import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void logout() {
    final auth = AuthService();

    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Iconsax.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Iconsax.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Iconsax.setting),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text(
                "L O G O U T",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Iconsax.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
