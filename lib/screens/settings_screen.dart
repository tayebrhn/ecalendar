import '../state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkModeEnabled = false;
  void _hadleSwitch(bool value) {
    // Provider.of<ThemeProvider>(context, listen: false).switchTheme(value);
    context.read()<ThemeProvider>().switchTheme(value);
    _darkModeEnabled = true;
    _darkModeEnabled = _darkModeEnabled ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isSystem = themeProvider.themeMode == AppThemeMode.system;
    final isDark = themeProvider.themeMode == AppThemeMode.dark;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Use System Theme'),
                  subtitle: Text('Automatically update theme'),
                  value: isSystem,
                  onChanged: (useSystem) {
                    themeProvider.setTheme(
                      useSystem
                          ? AppThemeMode.system
                          : isDark
                          ? AppThemeMode.dark
                          : AppThemeMode.light,
                    );
                  },
                ),
                Divider(height: 1),
                SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Enable dark theme'),
                  value: isDark,
                  onChanged:
                      isSystem
                          ? null
                          : (isDarkSelected) {
                            themeProvider.setTheme(
                              isDarkSelected
                                  ? AppThemeMode.dark
                                  : AppThemeMode.light,
                            );
                          },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  subtitle: Text('English'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Privacy & Security'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Help & Support'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
