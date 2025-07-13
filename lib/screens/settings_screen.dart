import 'package:ecalendar/l10n/app_localizations.dart';
import '../state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isSystem = themeProvider.themeMode == AppThemeMode.system;
    final isDark = themeProvider.themeMode == AppThemeMode.dark;
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return ListView(
          padding: EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectLanguage,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansEthiopic',
                      ),
                    ),
                    SizedBox(height: 16),

                    // Build language options dynamically
                    ...LanguageProvider.supportedLanguages.entries.map((entry) {
                      final languageCode = entry.key;
                      final languageName = entry.value;

                      return RadioListTile<String>(
                        title: Text(
                          languageName,
                          style: TextStyle(
                            fontFamily: 'NotoSansEthiopic',
                            fontSize: 16,
                          ),
                        ),
                        value: languageCode,
                        groupValue: languageProvider.locale.languageCode,
                        onChanged: (value) {
                          if (value != null) {
                            // Use the provider to change language
                            languageProvider.setLanguage(value);
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),

            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.systemTheme),
                    subtitle: Text(AppLocalizations.of(context)!.themeDescription),
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
                    title: Text(AppLocalizations.of(context)!.darkMode),
                    subtitle: Text(AppLocalizations.of(context)!.darkModeDescription),
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
            // SizedBox(height: 20),
            // Card(
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: Icon(Icons.language),
            //         title: Text('Language'),
            //         subtitle: Text('English'),
            //         trailing: Icon(Icons.arrow_forward_ios),
            //         onTap: () {},
            //       ),
            //       Divider(height: 1),
            //       ListTile(
            //         leading: Icon(Icons.security),
            //         title: Text('Privacy & Security'),
            //         trailing: Icon(Icons.arrow_forward_ios),
            //         onTap: () {},
            //       ),
            //       Divider(height: 1),
            //       ListTile(
            //         leading: Icon(Icons.help),
            //         title: Text('Help & Support'),
            //         trailing: Icon(Icons.arrow_forward_ios),
            //         onTap: () {},
            //       ),
            //     ],
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
