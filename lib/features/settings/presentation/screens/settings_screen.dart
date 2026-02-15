import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/features/settings/presentation/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: Text(settings.themeMode.toString().split('.').last),
            trailing: Switch(
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (value) => notifier.toggleTheme(value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(
              settings.locale.languageCode == 'en' ? 'English' : 'Ukrainian',
            ),
            onTap: () {
              // Simple toggle for now, can be a dialog for more languages
              final newLocale = settings.locale.languageCode == 'en'
                  ? const Locale('uk')
                  : const Locale('en');
              notifier.setLocale(newLocale);
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const ListTile(title: Text('Version'), subtitle: Text('1.0.0')),
        ],
      ),
    );
  }
}
