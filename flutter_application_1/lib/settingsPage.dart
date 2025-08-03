import 'package:flutter/material.dart';
import 'EditProfilePage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String notificationValue = 'On';
    String languageValue = 'English';
    String themeValue = 'Light Mode';

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0), // خلفية بيج فاتح
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF003366),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF003366)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // عناصر الإعدادات مباشرة
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  buildSettingsItem(Icons.edit, "Edit profile information", onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfilePage()),
                    );
                  }),

                  // Notification toggle
                  ListTile(
                    leading: const Icon(Icons.notifications, color: Color(0xFF003366)),
                    title: const Text(
                      "Notification",
                      style: TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.w500),
                    ),
                    trailing: DropdownButton<String>(
                      value: notificationValue,
                      underline: Container(),
                      items: ["On", "Off"].map((value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                  ),

                  // Language selector
                  ListTile(
                    leading: const Icon(Icons.language, color: Color(0xFF003366)),
                    title: const Text(
                      "Language",
                      style: TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.w500),
                    ),
                    trailing: DropdownButton<String>(
                      value: languageValue,
                      underline: Container(),
                      items: ["English", "العربية"].map((value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                  ),

                  // Theme selector
                  ListTile(
                    leading: const Icon(Icons.palette, color: Color(0xFF003366)),
                    title: const Text(
                      "Theme",
                      style: TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.w500),
                    ),
                    trailing: DropdownButton<String>(
                      value: themeValue,
                      underline: Container(),
                      items: ["Light Mode", "Dark Mode"].map((value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Divider(height: 32),

                  buildSettingsItem(Icons.logout, "Sign Out", trailing: const Icon(Icons.arrow_forward_ios, size: 16)),
                  buildSettingsItem(Icons.help_outline, "Help & Support"),
                  buildSettingsItem(Icons.contact_mail, "Contact Us"),
                  buildSettingsItem(Icons.privacy_tip, "Privacy Policy"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsItem(IconData icon, String title, {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF003366)),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
