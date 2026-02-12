/// Константы приложения Global Diaspora Events.
library;

abstract final class AppConstants {
  /// Название приложения.
  static const appName = 'Global Diaspora Events';

  /// Версия MVP.
  static const appVersion = '0.1.0';

  /// Радиус поиска по умолчанию (в километрах).
  static const defaultSearchRadiusKm = 50.0;

  /// Максимальное количество событий на странице.
  static const eventsPageSize = 20;

  /// Ключи для SharedPreferences.
  static const prefOnboardingComplete = 'onboarding_complete';
  static const prefOriginCountry = 'origin_country';
  static const prefCurrentCity = 'current_city';
}

/// URL и ключи Supabase — передаются через --dart-define при сборке.
///
/// Пример запуска:
/// ```
/// flutter run \
///   --dart-define=SUPABASE_URL=https://xxx.supabase.co \
///   --dart-define=SUPABASE_ANON_KEY=eyJ...
/// ```
abstract final class SupabaseConfig {
  static const _envUrl = String.fromEnvironment('SUPABASE_URL');
  static const _envKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static String? _runtimeUrl;
  static String? _runtimeKey;

  static void setRuntimeConfig(String url, String key) {
    _runtimeUrl = url;
    _runtimeKey = key;
  }

  static String get supabaseUrl => _runtimeUrl ?? _envUrl;
  static String get supabaseAnonKey => _runtimeKey ?? _envKey;

  /// Проверка, что ключи сконфигурированы.
  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
