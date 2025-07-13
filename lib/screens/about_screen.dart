import 'package:ecalendar/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _appName = '';
  String _version = '';
  String _packageName = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appName = info.appName;
      _version = info.version;
      _packageName = info.packageName;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.settings)
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Icon(Icons.info_outline, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            _appName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Version $_version',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.appDescription,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(AppLocalizations.of(context)!.gitRepo),
            onTap: () => _launchURL('https://github.com/ty-ab'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.developer),
            subtitle: const Text('Taye B.'),
            onTap: () => _launchURL('https://notyet.com'),
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: Text(AppLocalizations.of(context)!.viewOpenSourceL),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: _appName,
                applicationVersion: _version,
              );
            },
          ),
          const Divider(height: 32),
          Text(
            '© ${DateTime.now().year} Taye B. All rights reserved.\n'
            'This app is open-source and licensed under the MIT License.',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
