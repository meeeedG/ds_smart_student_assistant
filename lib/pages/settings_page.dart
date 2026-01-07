import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = "Français";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
        centerTitle: true,
      ),

      body: ListView(
        children: [

          SwitchListTile(
            title: const Text("Mode sombre"),
            subtitle: const Text("Activer le thème sombre"),
            value: ThemeController.themeMode.value == ThemeMode.dark,
            onChanged: (value) {
              ThemeController.themeMode.value =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
          ),

          const Divider(),

          SwitchListTile(
            title: const Text("Notifications"),
            subtitle: const Text("Recevoir des notifications"),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
