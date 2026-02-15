import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Settings State
class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState({required this.themeMode, required this.locale});

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

// Settings Controller
class SettingsController extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    final box = Hive.box('settings');
    final themeIndex = box.get('themeMode', defaultValue: 0) as int;
    final localeCode = box.get('locale', defaultValue: 'en') as String;

    return SettingsState(
      themeMode: ThemeMode.values[themeIndex],
      locale: Locale(localeCode),
    );
  }

  void toggleTheme(bool isDark) {
    final mode = isDark ? ThemeMode.dark : ThemeMode.light;
    state = state.copyWith(themeMode: mode);
    Hive.box('settings').put('themeMode', mode.index);
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    Hive.box('settings').put('themeMode', mode.index);
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);
    Hive.box('settings').put('locale', locale.languageCode);
  }
}

final settingsProvider = NotifierProvider<SettingsController, SettingsState>(
  () {
    return SettingsController();
  },
);
