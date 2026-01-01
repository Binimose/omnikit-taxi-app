import 'package:flutter/material.dart';
import '../../core/theme/taxi_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text("Preferences", style: TaxiTheme.headingMedium),
          const SizedBox(height: 16),
          _buildSettingItem(
            Icons.home,
            "Saved Places",
            "Manage Home, Work, and Favorites",
            () {},
          ),
          _buildSettingItem(
            Icons.notifications,
            "Notifications",
            "Manage push notifications",
            () {},
          ),
          _buildSettingItem(Icons.language, "Language", "English (US)", () {}),
          _buildSettingItem(Icons.dark_mode, "Dark Mode", "Off", () {}),

          const SizedBox(height: 32),
          Text("Support", style: TaxiTheme.headingMedium),
          const SizedBox(height: 16),
          _buildSettingItem(Icons.help, "Help Center", "Get support", () {}),
          _buildSettingItem(Icons.privacy_tip, "Privacy Policy", null, () {}),

          const SizedBox(height: 32),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Clear session and go to login
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 32),
          const Center(
            child: Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String? subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black87),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 12))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
