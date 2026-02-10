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

/// URL и ключи Supabase — загружаются из .env.
abstract final class SupabaseConfig {
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );
}
