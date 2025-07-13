// OPTIONAL: Custom widget for language selector
import 'package:ecalendar/l10n/app_localizations.dart';
import 'package:ecalendar/state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  final bool showTitle;
  
  const LanguageSelector({super.key, this.showTitle = true});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTitle) ...[
              Text(
                AppLocalizations.of(context)!.month,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansEthiopic',
                ),
              ),
              SizedBox(height: 16),
            ],
            
            ...LanguageProvider.supportedLanguages.entries.map((entry) {
              return ListTile(
                title: Text(
                  entry.value,
                  style: TextStyle(fontFamily: 'NotoSansEthiopic'),
                ),
                leading: Radio<String>(
                  value: entry.key,
                  groupValue: languageProvider.locale.languageCode,
                  onChanged: (value) {
                    if (value != null) {
                      languageProvider.setLanguage(value);
                    }
                  },
                ),
                onTap: () {
                  languageProvider.setLanguage(entry.key);
                },
              );
            }),
          ],
        );
      },
    );
  }
}