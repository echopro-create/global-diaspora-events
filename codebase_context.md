File: pubspec.yaml
```
name: gde
description: "Global Diaspora Events — find your people, find your events."
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: ^3.10.8

dependencies:
  flutter:
    sdk: flutter

  # UI
  cupertino_icons: ^1.0.8
  cached_network_image: ^3.4.1
  flutter_svg: ^2.0.17
  shimmer: ^3.0.0
  google_fonts: ^6.2.1

  # State Management
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1

  # Navigation
  go_router: ^15.1.2

  # Backend
  supabase_flutter: ^2.9.0

  # Location
  geolocator: ^13.0.2
  geocoding: ^3.0.0

  # Utils
  url_launcher: ^6.3.1
  intl: ^0.20.2
  shared_preferences: ^2.3.4
  connectivity_plus: ^6.1.1
  uuid: ^4.5.1

  # Models
  freezed_annotation: ^3.0.0
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.14
  freezed: ^3.0.0
  json_serializable: ^6.9.4
  riverpod_generator: ^2.6.3
  custom_lint: ^0.7.1
  riverpod_lint: ^2.6.3

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/

```

File: analysis_options.yaml
```
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options

```

File: README.md
```
# Global Diaspora Events

```

File: lib/main.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/constants/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  runApp(const ProviderScope(child: App()));
}

```

File: lib/core/constants/app_constants.dart
```
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

```

File: lib/core/widgets/shimmer_skeletons.dart
```
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/theme.dart';

/// Shimmer-скелетон для карточки события в списке.
class EventCardSkeleton extends StatelessWidget {
  const EventCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardDark,
      highlightColor: AppColors.surfaceDark.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 320,
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Изображение
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Дата
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Заголовок
                    Container(
                      width: double.infinity,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Подзаголовок
                    Container(
                      width: 200,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Теги + кнопка
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 60,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Список shimmer-скелетонов для ленты событий.
class EventListSkeleton extends StatelessWidget {
  final int count;
  const EventListSkeleton({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      itemBuilder: (_, __) => const EventCardSkeleton(),
    );
  }
}

/// Shimmer-скелетон для горизонтального carousel.
class CarouselSkeleton extends StatelessWidget {
  const CarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardDark,
      highlightColor: AppColors.surfaceDark.withValues(alpha: 0.8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

/// Shimmer-скелетон для категорий (горизонтальные чипсы).
class CategoryChipsSkeleton extends StatelessWidget {
  const CategoryChipsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.cardDark,
      highlightColor: AppColors.surfaceDark.withValues(alpha: 0.8),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (_, __) => Container(
            width: 90,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

```

File: lib/core/providers/core_providers.dart
```
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Core provider — Supabase client singleton.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider для текущего auth-пользователя (null если не авторизован).
final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

/// Stream-provider для изменений auth state.
final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

```

File: lib/app/theme.dart
```
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Цветовая палитра приложения Global Diaspora Events.
abstract final class AppColors {
  // Primary — тёплый фиолетовый, создающий ощущение глобальности
  static const primary = Color(0xFF6C5CE7);
  static const primaryLight = Color(0xFF9B8FEF);
  static const primaryDark = Color(0xFF4A3CB8);

  // Secondary — коралловый, передающий энергию событий
  static const secondary = Color(0xFFFF6B6B);
  static const secondaryLight = Color(0xFFFF9A9A);

  // Accent — солнечный жёлтый для акцентов
  static const accent = Color(0xFFFFD93D);

  // Neutrals
  static const backgroundDark = Color(0xFF0F0F1A);
  static const surfaceDark = Color(0xFF1A1A2E);
  static const cardDark = Color(0xFF222240);
  static const textPrimary = Color(0xFFF5F5F5);
  static const textSecondary = Color(0xFFB0B0C8);
  static const textMuted = Color(0xFF6C6C8A);
  static const divider = Color(0xFF2A2A4A);

  // Semantic
  static const success = Color(0xFF00C853);
  static const error = Color(0xFFFF5252);
  static const warning = Color(0xFFFFAB40);
}

/// Тема приложения.
abstract final class AppTheme {
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 28,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cardDark,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

```

File: lib/app/router.dart
```
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/events/presentation/screens/event_detail_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/events/presentation/screens/search_screen.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import 'widgets/main_shell.dart';

/// Маршрутизация приложения.
abstract final class AppRouter {
  /// Ключи навигации для каждой ветки.
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _discoverKey = GlobalKey<NavigatorState>(debugLabel: 'discover');
  static final _searchKey = GlobalKey<NavigatorState>(debugLabel: 'search');
  static final _profileKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

  /// Именованные маршруты.
  static const home = '/';
  static const eventDetail = '/event/:id';
  static const onboarding = '/onboarding';
  static const profile = '/profile';

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: home,
    routes: [
      // Онбординг — без BottomNavigationBar
      GoRoute(
        path: onboarding,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Event Detail — без BottomNavigationBar (full-screen)
      GoRoute(
        path: eventDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailScreen(eventId: eventId);
        },
      ),

      // Основная навигация с BottomNavigationBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Discover branch
          StatefulShellBranch(
            navigatorKey: _discoverKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const EventsScreen(),
              ),
            ],
          ),

          // Search branch
          StatefulShellBranch(
            navigatorKey: _searchKey,
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),

          // Profile branch
          StatefulShellBranch(
            navigatorKey: _profileKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

```

File: lib/app/app.dart
```
import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

/// Корневой виджет приложения.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Global Diaspora Events',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}

```

File: lib/app/widgets/main_shell.dart
```
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';

/// Shell-обёртка с BottomNavigationBar для основных разделов.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          indicatorColor: AppColors.primary.withValues(alpha: 0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(
                Icons.explore_rounded,
                color: AppColors.primary,
              ),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(
                Icons.person_rounded,
                color: AppColors.primary,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

```

File: lib/features/tags/domain/entities/tag.dart
```
/// Модель тега события.
class Tag {
  final String id;
  final String name;
  final String slug;
  final DateTime createdAt;

  const Tag({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'slug': slug};
  }
}

```

File: lib/features/profile/data/datasources/profile_remote_datasource.dart
```
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';

/// Remote data source для профиля пользователя (Supabase).
class ProfileRemoteDataSource {
  final SupabaseClient _client;

  ProfileRemoteDataSource(this._client);

  /// Получить текущего авторизованного пользователя.
  String? get currentUserId => _client.auth.currentUser?.id;

  /// Получить профиль по ID.
  Future<UserProfile?> getProfile(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserProfile.fromJson(response);
  }

  /// Обновить профиль пользователя.
  Future<UserProfile> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
      'display_name': ?displayName,
      'avatar_url': ?avatarUrl,
      'origin_country': ?originCountry,
      'current_city': ?currentCity,
      'latitude': ?latitude,
      'longitude': ?longitude,
    };

    final response = await _client
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  // ─── User Interests ───────────────────────────────────────────

  /// Получить интересы пользователя.
  Future<List<UserInterest>> getInterests(String profileId) async {
    final response = await _client
        .from('user_interests')
        .select()
        .eq('profile_id', profileId)
        .order('weight', ascending: false);

    return (response as List)
        .map((json) => UserInterest.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Добавить интерес.
  Future<UserInterest> addInterest(UserInterest interest) async {
    final response = await _client
        .from('user_interests')
        .insert(interest.toJson())
        .select()
        .single();

    return UserInterest.fromJson(response);
  }

  /// Удалить интерес.
  Future<void> removeInterest(String interestId) async {
    await _client.from('user_interests').delete().eq('id', interestId);
  }

  /// Добавить несколько интересов за раз (для импорта из Spotify).
  Future<List<UserInterest>> addInterestsBatch(
    List<UserInterest> interests,
  ) async {
    if (interests.isEmpty) return [];

    final response = await _client
        .from('user_interests')
        .insert(interests.map((i) => i.toJson()).toList())
        .select();

    return (response as List)
        .map((json) => UserInterest.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

```

File: lib/features/profile/data/repositories/profile_repository_impl.dart
```
import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';
import '../datasources/profile_remote_datasource.dart';

/// Репозиторий профиля пользователя.
class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepository(this._remoteDataSource);

  String? get currentUserId => _remoteDataSource.currentUserId;

  Future<UserProfile?> getProfile(String userId) {
    return _remoteDataSource.getProfile(userId);
  }

  Future<UserProfile> updateProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
  }) {
    return _remoteDataSource.updateProfile(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      originCountry: originCountry,
      currentCity: currentCity,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<List<UserInterest>> getInterests(String profileId) {
    return _remoteDataSource.getInterests(profileId);
  }

  Future<UserInterest> addInterest(UserInterest interest) {
    return _remoteDataSource.addInterest(interest);
  }

  Future<void> removeInterest(String interestId) {
    return _remoteDataSource.removeInterest(interestId);
  }

  Future<List<UserInterest>> addInterestsBatch(List<UserInterest> interests) {
    return _remoteDataSource.addInterestsBatch(interests);
  }
}

```

File: lib/features/profile/domain/entities/user_profile.dart
```
/// Модель профиля пользователя.
class UserProfile {
  final String id;
  final String? displayName;
  final String? avatarUrl;
  final String? originCountry;
  final String? currentCity;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.originCountry,
    this.currentCity,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      originCountry: json['origin_country'] as String?,
      currentCity: json['current_city'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (originCountry != null) 'origin_country': originCountry,
      if (currentCity != null) 'current_city': currentCity,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      originCountry: originCountry ?? this.originCountry,
      currentCity: currentCity ?? this.currentCity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

```

File: lib/features/profile/domain/entities/user_interest.dart
```
/// Модель интереса пользователя (artist, tag, category).
class UserInterest {
  final String id;
  final String profileId;
  final String interestType; // 'artist', 'tag', 'category'
  final String value;
  final double weight;
  final DateTime createdAt;

  const UserInterest({
    required this.id,
    required this.profileId,
    required this.interestType,
    required this.value,
    this.weight = 1.0,
    required this.createdAt,
  });

  factory UserInterest.fromJson(Map<String, dynamic> json) {
    return UserInterest(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      interestType: json['interest_type'] as String,
      value: json['value'] as String,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'interest_type': interestType,
      'value': value,
      'weight': weight,
    };
  }
}

```

File: lib/features/profile/presentation/screens/profile_screen.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';
import '../../../profile/presentation/providers/profile_providers.dart';

/// Экран профиля пользователя.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (_, __) => _buildAuthPrompt(context),
          data: (profile) {
            if (profile == null) return _buildAuthPrompt(context);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Avatar
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.primary,
                          backgroundImage: profile.avatarUrl != null
                              ? NetworkImage(profile.avatarUrl!)
                              : null,
                          child: profile.avatarUrl == null
                              ? const Icon(
                                  Icons.person_rounded,
                                  size: 48,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          profile.displayName ?? 'Diaspora Member',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Origin / City
                        Text(
                          [
                            if (profile.originCountry != null)
                              'From ${profile.originCountry}',
                            if (profile.currentCity != null)
                              'in ${profile.currentCity}',
                          ].join(' · '),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Stats cards
                        _buildInfoCard(
                          icon: Icons.public_rounded,
                          color: AppColors.primary,
                          label: 'Origin Country',
                          value: profile.originCountry ?? 'Not set',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          icon: Icons.location_city_rounded,
                          color: AppColors.secondary,
                          label: 'Current City',
                          value: profile.currentCity ?? 'Not set',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          icon: Icons.calendar_today_rounded,
                          color: AppColors.accent,
                          label: 'Joined',
                          value: _formatDate(profile.createdAt),
                        ),

                        const SizedBox(height: 32),

                        // Actions
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/onboarding'),
                            icon: const Icon(Icons.edit_rounded),
                            label: const Text('Edit Profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAuthPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Join the community',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign in to save events, connect\nwith your diaspora and more',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Auth flow
                },
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

```

File: lib/features/profile/presentation/providers/profile_providers.dart
```
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_interest.dart';
import '../../domain/entities/user_profile.dart';

/// Provider для ProfileRemoteDataSource.
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  return ProfileRemoteDataSource(ref.watch(supabaseClientProvider));
});

/// Provider для ProfileRepository.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(profileRemoteDataSourceProvider));
});

/// Provider для текущего профиля пользователя.
final currentProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile(user.id);
});

/// Provider для интересов текущего пользователя.
final userInterestsProvider = FutureProvider<List<UserInterest>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final repo = ref.watch(profileRepositoryProvider);
  return repo.getInterests(user.id);
});

/// Notifier для обновления профиля.
final updateProfileProvider =
    FutureProvider.family<
      UserProfile,
      ({
        String? displayName,
        String? originCountry,
        String? currentCity,
        double? latitude,
        double? longitude,
      })
    >((ref, params) async {
      final user = ref.watch(currentUserProvider);
      if (user == null) throw Exception('Not authenticated');

      final repo = ref.watch(profileRepositoryProvider);
      final result = await repo.updateProfile(
        userId: user.id,
        displayName: params.displayName,
        originCountry: params.originCountry,
        currentCity: params.currentCity,
        latitude: params.latitude,
        longitude: params.longitude,
      );

      // Инвалидируем кэш профиля
      ref.invalidate(currentProfileProvider);
      return result;
    });

```

File: lib/features/onboarding/presentation/screens/onboarding_screen.dart
```
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';

/// Экран онбординга — выбор страны и интересов.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  // Список стран (можно расширить)
  final _countries = [
    '🇺🇦 Ukraine',
    '🇷🇺 Russia',
    '🇵🇱 Poland',
    '🇩🇪 Germany',
    '🇫🇷 France',
    '🇪🇸 Spain',
    '🇮🇹 Italy',
    '🇬🇧 United Kingdom',
    '🇺🇸 United States',
    '🇨🇦 Canada',
    '🇹🇷 Turkey',
    '🇬🇪 Georgia',
    '🇰🇿 Kazakhstan',
    '🇮🇱 Israel',
    '🇦🇪 UAE',
  ];

  String? _selectedCountry;

  // Категории интересов
  final _interests = [
    ('🎵', 'Concerts'),
    ('⚽', 'Sports'),
    ('😆', 'Stand-Up'),
    ('💼', 'Business'),
    ('👶', 'Kids'),
    ('🎭', 'Theatre'),
    ('🎪', 'Festivals'),
    ('🎨', 'Art & Exhibitions'),
  ];

  final _selectedInterests = <String>{};

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= _currentPage
                            ? AppColors.primary
                            : AppColors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Pages
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                },
                children: [
                  _buildWelcomePage(),
                  _buildCountryPage(),
                  _buildInterestsPage(),
                ],
              ),
            ),

            // Navigation
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _canProceed() ? _onNext : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                    ),
                    child: Text(_currentPage == 2 ? "Let's go!" : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return true;
      case 1:
        return _selectedCountry != null;
      case 2:
        return _selectedInterests.isNotEmpty;
      default:
        return false;
    }
  }

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Завершение онбординга → переход на главную
      context.go('/');
    }
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.public_rounded,
              size: 56,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Welcome to\nGlobal Diaspora Events',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Find your people.\nFind your events.\nStay connected to your culture.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Where are you from?',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This helps us find events from your culture',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _countries.length,
              itemBuilder: (context, index) {
                final country = _countries[index];
                final isSelected = _selectedCountry == country;

                return GestureDetector(
                  onTap: () => setState(() => _selectedCountry = country),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.cardDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.divider,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          country,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontSize: 16,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'What are you into?',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pick at least one to personalize your feed',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _interests.length,
              itemBuilder: (context, index) {
                final (emoji, name) = _interests[index];
                final isSelected = _selectedInterests.contains(name);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedInterests.remove(name);
                      } else {
                        _selectedInterests.add(name);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.cardDark,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.divider,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(emoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 4),
                        Text(
                          name,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

```

File: lib/features/categories/data/datasources/categories_remote_datasource.dart
```
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/category.dart';

/// Remote data source для категорий (Supabase).
class CategoriesRemoteDataSource {
  final SupabaseClient _client;

  CategoriesRemoteDataSource(this._client);

  /// Получить все категории.
  Future<List<Category>> getCategories() async {
    final response = await _client
        .from('categories')
        .select()
        .order('sort_order');

    return (response as List)
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Получить категорию по ID.
  Future<Category> getCategoryById(String id) async {
    final response = await _client
        .from('categories')
        .select()
        .eq('id', id)
        .single();

    return Category.fromJson(response);
  }
}

```

File: lib/features/categories/data/repositories/categories_repository_impl.dart
```
import '../../domain/entities/category.dart';
import '../datasources/categories_remote_datasource.dart';

/// Репозиторий категорий.
class CategoriesRepository {
  final CategoriesRemoteDataSource _remoteDataSource;

  CategoriesRepository(this._remoteDataSource);

  Future<List<Category>> getCategories() {
    return _remoteDataSource.getCategories();
  }

  Future<Category> getCategoryById(String id) {
    return _remoteDataSource.getCategoryById(id);
  }
}

```

File: lib/features/categories/domain/entities/category.dart
```
/// Модель категории события.
class Category {
  final String id;
  final String name;
  final String slug;
  final String? icon;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.icon,
    this.sortOrder = 0,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      if (icon != null) 'icon': icon,
      'sort_order': sortOrder,
    };
  }
}

```

File: lib/features/categories/presentation/providers/categories_providers.dart
```
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/categories_remote_datasource.dart';
import '../../data/repositories/categories_repository_impl.dart';
import '../../domain/entities/category.dart';

/// Provider для CategoriesRemoteDataSource.
final categoriesRemoteDataSourceProvider = Provider<CategoriesRemoteDataSource>(
  (ref) {
    return CategoriesRemoteDataSource(ref.watch(supabaseClientProvider));
  },
);

/// Provider для CategoriesRepository.
final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(ref.watch(categoriesRemoteDataSourceProvider));
});

/// Provider для списка категорий.
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.getCategories();
});

/// Provider для одной категории по ID.
final categoryByIdProvider = FutureProvider.family<Category, String>((
  ref,
  id,
) async {
  final repo = ref.watch(categoriesRepositoryProvider);
  return repo.getCategoryById(id);
});

```

File: lib/features/events/data/datasources/events_remote_datasource.dart
```
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/event.dart';

/// Remote data source для событий (Supabase).
class EventsRemoteDataSource {
  final SupabaseClient _client;

  EventsRemoteDataSource(this._client);

  /// Получить список событий с фильтрацией.
  Future<List<Event>> getEvents({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    var query = _client
        .from('events')
        .select('*, event_tags(tags(name))')
        .gte('date_start', DateTime.now().toIso8601String())
        .order('is_promoted', ascending: false)
        .order('date_start')
        .range(offset, offset + limit - 1);

    if (categoryId != null) {
      query = _client
          .from('events')
          .select('*, event_tags(tags(name))')
          .eq('category_id', categoryId)
          .gte('date_start', DateTime.now().toIso8601String())
          .order('is_promoted', ascending: false)
          .order('date_start')
          .range(offset, offset + limit - 1);
    }

    final response = await query;
    return response.map((json) => _mapEventWithTags(json)).toList();
  }

  /// Получить события рядом (по координатам, используя RPC-функцию PostGIS).
  Future<List<Event>> getNearbyEvents({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
    int limit = 20,
  }) async {
    final response = await _client.rpc(
      'get_nearby_events',
      params: {
        'user_lat': latitude,
        'user_lng': longitude,
        'radius_km': radiusKm,
        'result_limit': limit,
      },
    );

    return (response as List)
        .map((json) => Event.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Получить одно событие по ID.
  Future<Event> getEventById(String id) async {
    final response = await _client
        .from('events')
        .select('*, event_tags(tags(name))')
        .eq('id', id)
        .single();

    return _mapEventWithTags(response);
  }

  /// Переключить участие в событии ("I'm going" / отмена).
  Future<bool> toggleParticipation({
    required String eventId,
    required String profileId,
  }) async {
    // Проверяем, участвует ли пользователь
    final existing = await _client
        .from('event_participants')
        .select()
        .eq('event_id', eventId)
        .eq('profile_id', profileId)
        .maybeSingle();

    if (existing != null) {
      // Уже участвует → удаляем
      await _client
          .from('event_participants')
          .delete()
          .eq('event_id', eventId)
          .eq('profile_id', profileId);
      return false;
    } else {
      // Не участвует → добавляем
      await _client.from('event_participants').insert({
        'event_id': eventId,
        'profile_id': profileId,
      });
      return true;
    }
  }

  /// Проверить, участвует ли пользователь в событии.
  Future<bool> isParticipating({
    required String eventId,
    required String profileId,
  }) async {
    final response = await _client
        .from('event_participants')
        .select()
        .eq('event_id', eventId)
        .eq('profile_id', profileId)
        .maybeSingle();

    return response != null;
  }

  /// Получить аватары участников события (первые N).
  Future<List<String>> getParticipantAvatars({
    required String eventId,
    int limit = 5,
  }) async {
    final response = await _client
        .from('event_participants')
        .select('profiles(avatar_url)')
        .eq('event_id', eventId)
        .limit(limit);

    return (response as List)
        .map((e) {
          final profile = e['profiles'] as Map<String, dynamic>?;
          return profile?['avatar_url'] as String? ?? '';
        })
        .where((url) => url.isNotEmpty)
        .toList();
  }

  /// Маппинг события с вложенными тегами из Supabase join.
  Event _mapEventWithTags(Map<String, dynamic> json) {
    final eventTags = json['event_tags'] as List<dynamic>? ?? [];
    final tags = eventTags
        .map((et) {
          final tag = et['tags'] as Map<String, dynamic>?;
          return tag?['name'] as String? ?? '';
        })
        .where((name) => name.isNotEmpty)
        .toList();

    return Event.fromJson({...json, 'tags': tags});
  }
}

```

File: lib/features/events/data/repositories/events_repository_impl.dart
```
import '../../domain/entities/event.dart';
import '../datasources/events_remote_datasource.dart';

/// Репозиторий событий.
class EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;

  EventsRepository(this._remoteDataSource);

  Future<List<Event>> getEvents({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  }) {
    return _remoteDataSource.getEvents(
      categoryId: categoryId,
      limit: limit,
      offset: offset,
    );
  }

  Future<List<Event>> getNearbyEvents({
    required double latitude,
    required double longitude,
    double radiusKm = 50.0,
    int limit = 20,
  }) {
    return _remoteDataSource.getNearbyEvents(
      latitude: latitude,
      longitude: longitude,
      radiusKm: radiusKm,
      limit: limit,
    );
  }

  Future<Event> getEventById(String id) {
    return _remoteDataSource.getEventById(id);
  }

  Future<bool> toggleParticipation({
    required String eventId,
    required String profileId,
  }) {
    return _remoteDataSource.toggleParticipation(
      eventId: eventId,
      profileId: profileId,
    );
  }

  Future<bool> isParticipating({
    required String eventId,
    required String profileId,
  }) {
    return _remoteDataSource.isParticipating(
      eventId: eventId,
      profileId: profileId,
    );
  }

  Future<List<String>> getParticipantAvatars({
    required String eventId,
    int limit = 5,
  }) {
    return _remoteDataSource.getParticipantAvatars(
      eventId: eventId,
      limit: limit,
    );
  }
}

```

File: lib/features/events/domain/entities/event.dart
```
/// Модель события.
class Event {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final DateTime dateStart;
  final DateTime? dateEnd;
  final String venueName;
  final String? venueAddress;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final String? buyLink;
  final bool isPromoted;
  final String? externalId;
  final String? source;
  final int participantsCount;
  final List<String> tags;
  final String? createdBy;
  final DateTime createdAt;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.dateStart,
    this.dateEnd,
    required this.venueName,
    this.venueAddress,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.buyLink,
    this.isPromoted = false,
    this.externalId,
    this.source,
    this.participantsCount = 0,
    this.tags = const [],
    this.createdBy,
    required this.createdAt,
  });

  /// Создание из JSON (Supabase row).
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['category_id'] as String,
      dateStart: DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] != null
          ? DateTime.parse(json['date_end'] as String)
          : null,
      venueName: json['venue_name'] as String? ?? '',
      venueAddress: json['venue_address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      buyLink: json['buy_link'] as String?,
      isPromoted: json['is_promoted'] as bool? ?? false,
      externalId: json['external_id'] as String?,
      source: json['source'] as String?,
      participantsCount: json['participants_count'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          const [],
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category_id': categoryId,
      'date_start': dateStart.toIso8601String(),
      if (dateEnd != null) 'date_end': dateEnd!.toIso8601String(),
      'venue_name': venueName,
      if (venueAddress != null) 'venue_address': venueAddress,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (imageUrl != null) 'image_url': imageUrl,
      if (buyLink != null) 'buy_link': buyLink,
      'is_promoted': isPromoted,
      if (externalId != null) 'external_id': externalId,
      if (source != null) 'source': source,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? venueName,
    String? venueAddress,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? buyLink,
    bool? isPromoted,
    String? externalId,
    String? source,
    int? participantsCount,
    List<String>? tags,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      venueName: venueName ?? this.venueName,
      venueAddress: venueAddress ?? this.venueAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      buyLink: buyLink ?? this.buyLink,
      isPromoted: isPromoted ?? this.isPromoted,
      externalId: externalId ?? this.externalId,
      source: source ?? this.source,
      participantsCount: participantsCount ?? this.participantsCount,
      tags: tags ?? this.tags,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

```

File: lib/features/events/presentation/screens/search_screen.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme.dart';
import '../providers/events_providers.dart';
import '../../domain/entities/event.dart';
import '../widgets/event_card.dart';

/// Экран поиска событий.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsProvider(null));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    onChanged: (v) => setState(() => _query = v.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: 'Events, artists, venues...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                      ),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear_rounded,
                                color: AppColors.textMuted,
                              ),
                              onPressed: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: eventsAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (_, __) => const Center(
                  child: Text(
                    'Search unavailable',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                data: (events) {
                  final filtered = _filterEvents(events);

                  if (_query.isEmpty) {
                    return _buildSearchHint();
                  }

                  if (filtered.isEmpty) {
                    return _buildNoResults();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return EventCard(event: filtered[index], onTap: () {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Event> _filterEvents(List<Event> events) {
    if (_query.isEmpty) return [];
    return events.where((e) {
      return e.title.toLowerCase().contains(_query) ||
          e.venueName.toLowerCase().contains(_query) ||
          e.description.toLowerCase().contains(_query) ||
          e.tags.any((t) => t.toLowerCase().contains(_query));
    }).toList();
  }

  Widget _buildSearchHint() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 64, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text(
            'Search for events',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Find concerts, festivals, exhibitions\nand more in your area',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords for "$_query"',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

```

File: lib/features/events/presentation/screens/events_screen.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme.dart';
import '../../../categories/presentation/providers/categories_providers.dart';
import '../providers/events_providers.dart';
import '../widgets/event_card.dart';

/// Главный экран — лента событий с сегментацией.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String? _selectedCategoryId;

  static const _tabs = ['For You', 'Nearby', 'Categories'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discover Events',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Find your people, find your events',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Аватар — тап → профиль
                        GestureDetector(
                          onTap: () => context.go('/profile'),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Поиск → переход на Search Tab
                    GestureDetector(
                      onTap: () => context.go('/search'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              color: AppColors.textMuted,
                              size: 22,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Search events, artists, venues...',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Табы
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textMuted,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  tabs: _tabs.map((t) => Tab(text: t)).toList(),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildForYouTab(),
              _buildNearbyTab(),
              _buildCategoriesTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForYouTab() {
    final eventsAsync = ref.watch(eventsProvider(null));

    return eventsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to load events',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => ref.invalidate(eventsProvider(null)),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
      data: (events) {
        if (events.isEmpty) {
          return _buildEmptyState();
        }
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider(null));
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                onTap: () => context.push('/event/${event.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNearbyTab() {
    // Заглушка — будет GPS-определение после подключения geolocator
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                size: 48,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Events near you',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enable location access to discover\nevents happening around you',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Request location permission
              },
              icon: const Icon(Icons.my_location_rounded),
              label: const Text('Enable Location'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesTab() {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (_, __) => const Center(
        child: Text(
          'Failed to load categories',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      data: (categories) {
        return Column(
          children: [
            // Горизонтальная полоска категорий
            SizedBox(
              height: 56,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: categories.length + 1, // +1 для "All"
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final isSelected = isAll
                      ? _selectedCategoryId == null
                      : _selectedCategoryId == categories[index - 1].id;

                  final label = isAll ? 'All' : categories[index - 1].name;
                  final icon = isAll
                      ? '🌍'
                      : (categories[index - 1].icon ?? '📋');

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = isAll
                            ? null
                            : categories[index - 1].id;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.cardDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(icon, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Список событий фильтрованный по категории
            Expanded(child: _buildCategoryEvents()),
          ],
        );
      },
    );
  }

  Widget _buildCategoryEvents() {
    final eventsAsync = ref.watch(eventsProvider(_selectedCategoryId));

    return eventsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (_, __) => const Center(
        child: Text(
          'Failed to load events',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
      data: (events) {
        if (events.isEmpty) return _buildEmptyState();

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider(_selectedCategoryId));
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                onTap: () => context.push('/event/${event.id}'),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy_rounded, size: 64, color: AppColors.textMuted),
          SizedBox(height: 16),
          Text(
            'No events yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Check back later for upcoming events',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// Делегат для закреплённого TabBar.
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.backgroundDark, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

```

File: lib/features/events/presentation/screens/event_detail_screen.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/theme.dart';
import '../providers/events_providers.dart';

/// Экран детальной информации о событии.
class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Failed to load event',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(eventDetailProvider(eventId)),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
        data: (event) {
          final dateFormat = DateFormat('EEEE, d MMMM yyyy • HH:mm');

          return CustomScrollView(
            slivers: [
              // Hero image
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.backgroundDark,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: event.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: event.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: AppColors.surfaceDark),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.4),
                                AppColors.secondary.withValues(alpha: 0.4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.event_rounded,
                              size: 64,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promoted badge
                      if (event.isPromoted)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.accent, AppColors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '⭐ Promoted Event',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                      // Название
                      Text(
                        event.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Info tiles
                      _buildInfoTile(
                        Icons.calendar_today_rounded,
                        AppColors.primary,
                        dateFormat.format(event.dateStart),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoTile(
                        Icons.location_on_rounded,
                        AppColors.secondary,
                        '${event.venueName}${event.venueAddress != null ? '\n${event.venueAddress}' : ''}',
                      ),
                      const SizedBox(height: 10),
                      _buildInfoTile(
                        Icons.people_rounded,
                        AppColors.primaryLight,
                        '${event.participantsCount} people going',
                      ),

                      const SizedBox(height: 24),

                      // Tags
                      if (event.tags.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.tags.map((tag) {
                            return Chip(
                              label: Text(
                                '#$tag',
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 13,
                                ),
                              ),
                              backgroundColor: AppColors.primary.withValues(
                                alpha: 0.15,
                              ),
                              side: BorderSide.none,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Description
                      const Text(
                        'About',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Toggle participation
                              },
                              icon: const Icon(Icons.check_circle_rounded),
                              label: const Text("I'm going"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (event.buyLink != null)
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  final uri = Uri.parse(event.buyLink!);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.confirmation_number_rounded,
                                ),
                                label: const Text('Buy Ticket'),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

```

File: lib/features/events/presentation/widgets/hero_carousel.dart
```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme.dart';
import '../../domain/entities/event.dart';

/// Hero Carousel — большие карточки promoted/featured событий.
class HeroCarousel extends StatefulWidget {
  final List<Event> events;
  final void Function(Event event) onTap;

  const HeroCarousel({super.key, required this.events, required this.onTap});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.92);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || widget.events.isEmpty) return;
      final nextPage = (_currentPage + 1) % widget.events.length;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              final event = widget.events[index];
              return _HeroCard(event: event, onTap: () => widget.onTap(event));
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.events.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: _currentPage == index ? 24 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : AppColors.textMuted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const _HeroCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEE, d MMM · HH:mm');
    final now = DateTime.now();
    final diff = event.dateStart.difference(now);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Фоновое изображение
            if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: event.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.cardDark),
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.cardDark),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.4),
                      AppColors.secondary.withValues(alpha: 0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

            // Gradient overlay для читаемости
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.2, 0.5, 1.0],
                ),
              ),
            ),

            // Countdown badge
            if (diff.isNegative == false)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    _formatCountdown(diff),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // Контент внизу
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Дата
                  Text(
                    dateFormat.format(event.dateStart),
                    style: TextStyle(
                      color: AppColors.accent.withValues(alpha: 0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Название
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Место + участники
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.venueName,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (event.participantsCount > 0) ...[
                        const SizedBox(width: 12),
                        Icon(
                          Icons.people_rounded,
                          size: 14,
                          color: AppColors.primary.withValues(alpha: 0.9),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${event.participantsCount}',
                          style: TextStyle(
                            color: AppColors.primary.withValues(alpha: 0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCountdown(Duration diff) {
    if (diff.inDays > 0) {
      return 'in ${diff.inDays}d';
    } else if (diff.inHours > 0) {
      return 'in ${diff.inHours}h';
    } else {
      return 'in ${diff.inMinutes}m';
    }
  }
}

```

File: lib/features/events/presentation/widgets/event_card.dart
```
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/event.dart';
import '../../../../app/theme.dart';

/// Карточка события с social proof.
class EventCard extends StatelessWidget {
  final Event event;
  final bool isParticipating;
  final VoidCallback? onTap;
  final VoidCallback? onToggleParticipation;

  const EventCard({
    super.key,
    required this.event,
    this.isParticipating = false,
    this.onTap,
    this.onToggleParticipation,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM, HH:mm');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: event.isPromoted
              ? Border.all(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  width: 1.5,
                )
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение
            _buildImage(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promoted badge
                  if (event.isPromoted)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accent, AppColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '⭐ Promoted',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  // Название
                  Text(
                    event.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Дата и место
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateFormat.format(event.dateStart),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.venueName,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Теги
                  if (event.tags.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: event.tags.take(3).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 12),

                  // Social proof + действия
                  Row(
                    children: [
                      // Participants count
                      _buildSocialProof(),
                      const Spacer(),

                      // I'm going button
                      _buildGoingButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (event.imageUrl == null || event.imageUrl!.isEmpty) {
      return Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.3),
              AppColors.secondary.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.event_rounded,
            size: 48,
            color: AppColors.textMuted,
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: event.imageUrl!,
      height: 160,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        height: 160,
        color: AppColors.surfaceDark,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        height: 160,
        color: AppColors.surfaceDark,
        child: const Center(
          child: Icon(Icons.broken_image_rounded, color: AppColors.textMuted),
        ),
      ),
    );
  }

  Widget _buildSocialProof() {
    if (event.participantsCount == 0) {
      return const Text(
        'Be the first to go!',
        style: TextStyle(
          color: AppColors.textMuted,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Row(
      children: [
        const Icon(
          Icons.people_rounded,
          size: 16,
          color: AppColors.primaryLight,
        ),
        const SizedBox(width: 4),
        Text(
          '${event.participantsCount} going',
          style: const TextStyle(
            color: AppColors.primaryLight,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGoingButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleParticipation,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isParticipating
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(
                alpha: isParticipating ? 1.0 : 0.4,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isParticipating
                    ? Icons.check_circle_rounded
                    : Icons.add_circle_outline_rounded,
                size: 16,
                color: isParticipating ? Colors.white : AppColors.primaryLight,
              ),
              const SizedBox(width: 6),
              Text(
                isParticipating ? "I'm going!" : "I'm going",
                style: TextStyle(
                  color: isParticipating
                      ? Colors.white
                      : AppColors.primaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

File: lib/features/events/presentation/providers/events_providers.dart
```
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/events_remote_datasource.dart';
import '../../data/repositories/events_repository_impl.dart';
import '../../domain/entities/event.dart';

/// Provider для EventsRemoteDataSource.
final eventsRemoteDataSourceProvider = Provider<EventsRemoteDataSource>((ref) {
  return EventsRemoteDataSource(ref.watch(supabaseClientProvider));
});

/// Provider для EventsRepository.
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.watch(eventsRemoteDataSourceProvider));
});

/// Provider для списка событий (фильтр по категории — nullable).
final eventsProvider = FutureProvider.family<List<Event>, String?>((
  ref,
  categoryId,
) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getEvents(categoryId: categoryId);
});

/// Provider для геопоиска.
final nearbyEventsProvider =
    FutureProvider.family<
      List<Event>,
      ({double lat, double lng, double radius})
    >((ref, params) async {
      final repo = ref.watch(eventsRepositoryProvider);
      return repo.getNearbyEvents(
        latitude: params.lat,
        longitude: params.lng,
        radiusKm: params.radius,
      );
    });

/// Provider для детальной информации о событии.
final eventDetailProvider = FutureProvider.family<Event, String>((
  ref,
  eventId,
) async {
  final repo = ref.watch(eventsRepositoryProvider);
  return repo.getEventById(eventId);
});

/// Provider для переключения участия.
final toggleParticipationProvider =
    FutureProvider.family<bool, ({String eventId, String profileId})>((
      ref,
      params,
    ) async {
      final repo = ref.watch(eventsRepositoryProvider);
      return repo.toggleParticipation(
        eventId: params.eventId,
        profileId: params.profileId,
      );
    });

```

File: test/widget_test.dart
```
import 'package:flutter_test/flutter_test.dart';

import 'package:gde/app/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Проверяем, что приложение запустилось
    expect(find.byType(App), findsOneWidget);
  });
}

```

File: supabase/config.toml
```
# For detailed configuration reference documentation, visit:
# https://supabase.com/docs/guides/local-development/cli/config
# A string used to distinguish different Supabase projects on the same host. Defaults to the
# working directory name when running `supabase init`.
project_id = "global-diaspora-events"

[api]
enabled = true
# Port to use for the API URL.
port = 54321
# Schemas to expose in your API. Tables, views and stored procedures in this schema will get API
# endpoints. `public` and `graphql_public` schemas are included by default.
schemas = ["public", "graphql_public"]
# Extra schemas to add to the search_path of every request.
extra_search_path = ["public", "extensions"]
# The maximum number of rows returns from a view, table, or stored procedure. Limits payload size
# for accidental or malicious requests.
max_rows = 1000

[api.tls]
# Enable HTTPS endpoints locally using a self-signed certificate.
enabled = false
# Paths to self-signed certificate pair.
# cert_path = "../certs/my-cert.pem"
# key_path = "../certs/my-key.pem"

[db]
# Port to use for the local database URL.
port = 54322
# Port used by db diff command to initialize the shadow database.
shadow_port = 54320
# Maximum amount of time to wait for health check when starting the local database.
health_timeout = "2m"
# The database major version to use. This has to be the same as your remote database's. Run `SHOW
# server_version;` on the remote database to check.
major_version = 17

[db.pooler]
enabled = false
# Port to use for the local connection pooler.
port = 54329
# Specifies when a server connection can be reused by other clients.
# Configure one of the supported pooler modes: `transaction`, `session`.
pool_mode = "transaction"
# How many server connections to allow per user/database pair.
default_pool_size = 20
# Maximum number of client connections allowed.
max_client_conn = 100

# [db.vault]
# secret_key = "env(SECRET_VALUE)"

[db.migrations]
# If disabled, migrations will be skipped during a db push or reset.
enabled = true
# Specifies an ordered list of schema files that describe your database.
# Supports glob patterns relative to supabase directory: "./schemas/*.sql"
schema_paths = []

[db.seed]
# If enabled, seeds the database after migrations during a db reset.
enabled = true
# Specifies an ordered list of seed files to load during db reset.
# Supports glob patterns relative to supabase directory: "./seeds/*.sql"
sql_paths = ["./seed.sql"]

[db.network_restrictions]
# Enable management of network restrictions.
enabled = false
# List of IPv4 CIDR blocks allowed to connect to the database.
# Defaults to allow all IPv4 connections. Set empty array to block all IPs.
allowed_cidrs = ["0.0.0.0/0"]
# List of IPv6 CIDR blocks allowed to connect to the database.
# Defaults to allow all IPv6 connections. Set empty array to block all IPs.
allowed_cidrs_v6 = ["::/0"]

[realtime]
enabled = true
# Bind realtime via either IPv4 or IPv6. (default: IPv4)
# ip_version = "IPv6"
# The maximum length in bytes of HTTP request headers. (default: 4096)
# max_header_length = 4096

[studio]
enabled = true
# Port to use for Supabase Studio.
port = 54323
# External URL of the API server that frontend connects to.
api_url = "http://127.0.0.1"
# OpenAI API Key to use for Supabase AI in the Supabase Studio.
openai_api_key = "env(OPENAI_API_KEY)"

# Email testing server. Emails sent with the local dev setup are not actually sent - rather, they
# are monitored, and you can view the emails that would have been sent from the web interface.
[inbucket]
enabled = true
# Port to use for the email testing server web interface.
port = 54324
# Uncomment to expose additional ports for testing user applications that send emails.
# smtp_port = 54325
# pop3_port = 54326
# admin_email = "admin@email.com"
# sender_name = "Admin"

[storage]
enabled = true
# The maximum file size allowed (e.g. "5MB", "500KB").
file_size_limit = "50MiB"

# Uncomment to configure local storage buckets
# [storage.buckets.images]
# public = false
# file_size_limit = "50MiB"
# allowed_mime_types = ["image/png", "image/jpeg"]
# objects_path = "./images"

# Allow connections via S3 compatible clients
[storage.s3_protocol]
enabled = true

# Image transformation API is available to Supabase Pro plan.
# [storage.image_transformation]
# enabled = true

# Store analytical data in S3 for running ETL jobs over Iceberg Catalog
# This feature is only available on the hosted platform.
[storage.analytics]
enabled = false
max_namespaces = 5
max_tables = 10
max_catalogs = 2

# Analytics Buckets is available to Supabase Pro plan.
# [storage.analytics.buckets.my-warehouse]

# Store vector embeddings in S3 for large and durable datasets
# This feature is only available on the hosted platform.
[storage.vector]
enabled = false
max_buckets = 10
max_indexes = 5

# Vector Buckets is available to Supabase Pro plan.
# [storage.vector.buckets.documents-openai]

[auth]
enabled = true
# The base URL of your website. Used as an allow-list for redirects and for constructing URLs used
# in emails.
site_url = "http://127.0.0.1:3000"
# A list of *exact* URLs that auth providers are permitted to redirect to post authentication.
additional_redirect_urls = ["https://127.0.0.1:3000"]
# How long tokens are valid for, in seconds. Defaults to 3600 (1 hour), maximum 604,800 (1 week).
jwt_expiry = 3600
# JWT issuer URL. If not set, defaults to the local API URL (http://127.0.0.1:<port>/auth/v1).
# jwt_issuer = ""
# Path to JWT signing key. DO NOT commit your signing keys file to git.
# signing_keys_path = "./signing_keys.json"
# If disabled, the refresh token will never expire.
enable_refresh_token_rotation = true
# Allows refresh tokens to be reused after expiry, up to the specified interval in seconds.
# Requires enable_refresh_token_rotation = true.
refresh_token_reuse_interval = 10
# Allow/disallow new user signups to your project.
enable_signup = true
# Allow/disallow anonymous sign-ins to your project.
enable_anonymous_sign_ins = false
# Allow/disallow testing manual linking of accounts
enable_manual_linking = false
# Passwords shorter than this value will be rejected as weak. Minimum 6, recommended 8 or more.
minimum_password_length = 6
# Passwords that do not meet the following requirements will be rejected as weak. Supported values
# are: `letters_digits`, `lower_upper_letters_digits`, `lower_upper_letters_digits_symbols`
password_requirements = ""

[auth.rate_limit]
# Number of emails that can be sent per hour. Requires auth.email.smtp to be enabled.
email_sent = 2
# Number of SMS messages that can be sent per hour. Requires auth.sms to be enabled.
sms_sent = 30
# Number of anonymous sign-ins that can be made per hour per IP address. Requires enable_anonymous_sign_ins = true.
anonymous_users = 30
# Number of sessions that can be refreshed in a 5 minute interval per IP address.
token_refresh = 150
# Number of sign up and sign-in requests that can be made in a 5 minute interval per IP address (excludes anonymous users).
sign_in_sign_ups = 30
# Number of OTP / Magic link verifications that can be made in a 5 minute interval per IP address.
token_verifications = 30
# Number of Web3 logins that can be made in a 5 minute interval per IP address.
web3 = 30

# Configure one of the supported captcha providers: `hcaptcha`, `turnstile`.
# [auth.captcha]
# enabled = true
# provider = "hcaptcha"
# secret = ""

[auth.email]
# Allow/disallow new user signups via email to your project.
enable_signup = true
# If enabled, a user will be required to confirm any email change on both the old, and new email
# addresses. If disabled, only the new email is required to confirm.
double_confirm_changes = true
# If enabled, users need to confirm their email address before signing in.
enable_confirmations = false
# If enabled, users will need to reauthenticate or have logged in recently to change their password.
secure_password_change = false
# Controls the minimum amount of time that must pass before sending another signup confirmation or password reset email.
max_frequency = "1s"
# Number of characters used in the email OTP.
otp_length = 6
# Number of seconds before the email OTP expires (defaults to 1 hour).
otp_expiry = 3600

# Use a production-ready SMTP server
# [auth.email.smtp]
# enabled = true
# host = "smtp.sendgrid.net"
# port = 587
# user = "apikey"
# pass = "env(SENDGRID_API_KEY)"
# admin_email = "admin@email.com"
# sender_name = "Admin"

# Uncomment to customize email template
# [auth.email.template.invite]
# subject = "You have been invited"
# content_path = "./supabase/templates/invite.html"

# Uncomment to customize notification email template
# [auth.email.notification.password_changed]
# enabled = true
# subject = "Your password has been changed"
# content_path = "./templates/password_changed_notification.html"

[auth.sms]
# Allow/disallow new user signups via SMS to your project.
enable_signup = false
# If enabled, users need to confirm their phone number before signing in.
enable_confirmations = false
# Template for sending OTP to users
template = "Your code is {{ .Code }}"
# Controls the minimum amount of time that must pass before sending another sms otp.
max_frequency = "5s"

# Use pre-defined map of phone number to OTP for testing.
# [auth.sms.test_otp]
# 4152127777 = "123456"

# Configure logged in session timeouts.
# [auth.sessions]
# Force log out after the specified duration.
# timebox = "24h"
# Force log out if the user has been inactive longer than the specified duration.
# inactivity_timeout = "8h"

# This hook runs before a new user is created and allows developers to reject the request based on the incoming user object.
# [auth.hook.before_user_created]
# enabled = true
# uri = "pg-functions://postgres/auth/before-user-created-hook"

# This hook runs before a token is issued and allows you to add additional claims based on the authentication method used.
# [auth.hook.custom_access_token]
# enabled = true
# uri = "pg-functions://<database>/<schema>/<hook_name>"

# Configure one of the supported SMS providers: `twilio`, `twilio_verify`, `messagebird`, `textlocal`, `vonage`.
[auth.sms.twilio]
enabled = false
account_sid = ""
message_service_sid = ""
# DO NOT commit your Twilio auth token to git. Use environment variable substitution instead:
auth_token = "env(SUPABASE_AUTH_SMS_TWILIO_AUTH_TOKEN)"

# Multi-factor-authentication is available to Supabase Pro plan.
[auth.mfa]
# Control how many MFA factors can be enrolled at once per user.
max_enrolled_factors = 10

# Control MFA via App Authenticator (TOTP)
[auth.mfa.totp]
enroll_enabled = false
verify_enabled = false

# Configure MFA via Phone Messaging
[auth.mfa.phone]
enroll_enabled = false
verify_enabled = false
otp_length = 6
template = "Your code is {{ .Code }}"
max_frequency = "5s"

# Configure MFA via WebAuthn
# [auth.mfa.web_authn]
# enroll_enabled = true
# verify_enabled = true

# Use an external OAuth provider. The full list of providers are: `apple`, `azure`, `bitbucket`,
# `discord`, `facebook`, `github`, `gitlab`, `google`, `keycloak`, `linkedin_oidc`, `notion`, `twitch`,
# `twitter`, `x`, `slack`, `spotify`, `workos`, `zoom`.
[auth.external.apple]
enabled = false
client_id = ""
# DO NOT commit your OAuth provider secret to git. Use environment variable substitution instead:
secret = "env(SUPABASE_AUTH_EXTERNAL_APPLE_SECRET)"
# Overrides the default auth redirectUrl.
redirect_uri = ""
# Overrides the default auth provider URL. Used to support self-hosted gitlab, single-tenant Azure,
# or any other third-party OIDC providers.
url = ""
# If enabled, the nonce check will be skipped. Required for local sign in with Google auth.
skip_nonce_check = false
# If enabled, it will allow the user to successfully authenticate when the provider does not return an email address.
email_optional = false

# Allow Solana wallet holders to sign in to your project via the Sign in with Solana (SIWS, EIP-4361) standard.
# You can configure "web3" rate limit in the [auth.rate_limit] section and set up [auth.captcha] if self-hosting.
[auth.web3.solana]
enabled = false

# Use Firebase Auth as a third-party provider alongside Supabase Auth.
[auth.third_party.firebase]
enabled = false
# project_id = "my-firebase-project"

# Use Auth0 as a third-party provider alongside Supabase Auth.
[auth.third_party.auth0]
enabled = false
# tenant = "my-auth0-tenant"
# tenant_region = "us"

# Use AWS Cognito (Amplify) as a third-party provider alongside Supabase Auth.
[auth.third_party.aws_cognito]
enabled = false
# user_pool_id = "my-user-pool-id"
# user_pool_region = "us-east-1"

# Use Clerk as a third-party provider alongside Supabase Auth.
[auth.third_party.clerk]
enabled = false
# Obtain from https://clerk.com/setup/supabase
# domain = "example.clerk.accounts.dev"

# OAuth server configuration
[auth.oauth_server]
# Enable OAuth server functionality
enabled = false
# Path for OAuth consent flow UI
authorization_url_path = "/oauth/consent"
# Allow dynamic client registration
allow_dynamic_registration = false

[edge_runtime]
enabled = true
# Supported request policies: `oneshot`, `per_worker`.
# `per_worker` (default) — enables hot reload during local development.
# `oneshot` — fallback mode if hot reload causes issues (e.g. in large repos or with symlinks).
policy = "per_worker"
# Port to attach the Chrome inspector for debugging edge functions.
inspector_port = 8083
# The Deno major version to use.
deno_version = 2

# [edge_runtime.secrets]
# secret_key = "env(SECRET_VALUE)"

[analytics]
enabled = true
port = 54327
# Configure one of the supported backends: `postgres`, `bigquery`.
backend = "postgres"

# Experimental features may be deprecated any time
[experimental]
# Configures Postgres storage engine to use OrioleDB (S3)
orioledb_version = ""
# Configures S3 bucket URL, eg. <bucket_name>.s3-<region>.amazonaws.com
s3_host = "env(S3_HOST)"
# Configures S3 bucket region, eg. us-east-1
s3_region = "env(S3_REGION)"
# Configures AWS_ACCESS_KEY_ID for S3 bucket
s3_access_key = "env(S3_ACCESS_KEY)"
# Configures AWS_SECRET_ACCESS_KEY for S3 bucket
s3_secret_key = "env(S3_SECRET_KEY)"

```

File: supabase/migrations/20260210190000_initial_schema.sql
```
-- =================================================================
-- Global Diaspora Events — Initial Database Schema
-- =================================================================
-- PostGIS + 7 tables + RLS + triggers + seed data
-- =================================================================

-- 1. EXTENSIONS
-- -----------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "postgis";

-- 2. TABLES
-- -----------------------------------------------------------------

-- 2.1 Profiles (extends auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
  id            UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name  TEXT,
  avatar_url    TEXT,
  origin_country TEXT,
  current_city  TEXT,
  location      GEOGRAPHY(Point, 4326),
  -- denormalized lat/lng for easy SELECT
  latitude      DOUBLE PRECISION,
  longitude     DOUBLE PRECISION,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.2 Categories
CREATE TABLE IF NOT EXISTS public.categories (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  slug       TEXT NOT NULL UNIQUE,
  icon       TEXT,            -- Material icon name or emoji
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.3 Tags
CREATE TABLE IF NOT EXISTS public.tags (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL UNIQUE,
  slug       TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2.4 Events
CREATE TABLE IF NOT EXISTS public.events (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title              TEXT NOT NULL,
  description        TEXT DEFAULT '',
  category_id        UUID NOT NULL REFERENCES public.categories(id) ON DELETE RESTRICT,
  date_start         TIMESTAMPTZ NOT NULL,
  date_end           TIMESTAMPTZ,
  venue_name         TEXT NOT NULL DEFAULT '',
  venue_address      TEXT,
  location           GEOGRAPHY(Point, 4326),
  -- denormalized lat/lng
  latitude           DOUBLE PRECISION,
  longitude          DOUBLE PRECISION,
  image_url          TEXT,
  buy_link           TEXT,
  is_promoted        BOOLEAN NOT NULL DEFAULT false,
  external_id        TEXT,          -- for deduplication from scrapers
  source             TEXT,          -- 'ticketmaster', 'eventim', 'telegram', 'manual'
  participants_count INT NOT NULL DEFAULT 0,
  created_by         UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Unique constraint for external deduplication
CREATE UNIQUE INDEX IF NOT EXISTS idx_events_external_id
  ON public.events(external_id) WHERE external_id IS NOT NULL;

-- Spatial index for geo-queries
CREATE INDEX IF NOT EXISTS idx_events_location
  ON public.events USING GIST(location);

-- Index for date queries
CREATE INDEX IF NOT EXISTS idx_events_date_start
  ON public.events(date_start);

-- 2.5 Event Tags (many-to-many)
CREATE TABLE IF NOT EXISTS public.event_tags (
  event_id UUID NOT NULL REFERENCES public.events(id) ON DELETE CASCADE,
  tag_id   UUID NOT NULL REFERENCES public.tags(id)   ON DELETE CASCADE,
  PRIMARY KEY (event_id, tag_id)
);

-- 2.6 Event Participants ("I'm going")
CREATE TABLE IF NOT EXISTS public.event_participants (
  event_id   UUID NOT NULL REFERENCES public.events(id)   ON DELETE CASCADE,
  profile_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, profile_id)
);

-- 2.7 User Interests
CREATE TABLE IF NOT EXISTS public.user_interests (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  interest_type  TEXT NOT NULL CHECK (interest_type IN ('artist', 'tag', 'category')),
  value          TEXT NOT NULL,       -- artist name, tag slug, or category slug
  weight         REAL NOT NULL DEFAULT 1.0,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_interests_profile
  ON public.user_interests(profile_id);


-- 3. TRIGGERS — auto-update participants_count
-- -----------------------------------------------------------------

-- Function to update count
CREATE OR REPLACE FUNCTION public.update_participants_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE public.events
    SET participants_count = participants_count + 1,
        updated_at = now()
    WHERE id = NEW.event_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE public.events
    SET participants_count = GREATEST(participants_count - 1, 0),
        updated_at = now()
    WHERE id = OLD.event_id;
    RETURN OLD;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger on event_participants
CREATE TRIGGER trigger_update_participants_count
  AFTER INSERT OR DELETE ON public.event_participants
  FOR EACH ROW
  EXECUTE FUNCTION public.update_participants_count();


-- 4. AUTO-CREATE profile on signup
-- -----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();


-- 5. FUNCTION — Nearby events geo-search (PostGIS)
-- -----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.get_nearby_events(
  user_lat    DOUBLE PRECISION,
  user_lng    DOUBLE PRECISION,
  radius_km   DOUBLE PRECISION DEFAULT 50.0,
  result_limit INT DEFAULT 20
)
RETURNS SETOF public.events AS $$
BEGIN
  RETURN QUERY
    SELECT e.*
    FROM public.events e
    WHERE e.location IS NOT NULL
      AND e.date_start >= now()
      AND ST_DWithin(
            e.location,
            ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography,
            radius_km * 1000  -- convert km to meters
          )
    ORDER BY
      e.is_promoted DESC,
      ST_Distance(
        e.location,
        ST_SetSRID(ST_MakePoint(user_lng, user_lat), 4326)::geography
      )
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 6. ROW LEVEL SECURITY (RLS)
-- -----------------------------------------------------------------

-- Profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Profiles: public read"
  ON public.profiles FOR SELECT
  USING (true);

CREATE POLICY "Profiles: owner insert"
  ON public.profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Profiles: owner update"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Categories (public read-only)
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Categories: public read"
  ON public.categories FOR SELECT
  USING (true);

-- Tags (public read-only)
ALTER TABLE public.tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Tags: public read"
  ON public.tags FOR SELECT
  USING (true);

-- Events (public read; authenticated users can insert)
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Events: public read"
  ON public.events FOR SELECT
  USING (true);

CREATE POLICY "Events: authenticated insert"
  ON public.events FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Events: creator update"
  ON public.events FOR UPDATE
  USING (auth.uid() = created_by);

-- Event Tags (public read)
ALTER TABLE public.event_tags ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Event tags: public read"
  ON public.event_tags FOR SELECT
  USING (true);

-- Event Participants
ALTER TABLE public.event_participants ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Participants: public read"
  ON public.event_participants FOR SELECT
  USING (true);

CREATE POLICY "Participants: owner insert"
  ON public.event_participants FOR INSERT
  WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Participants: owner delete"
  ON public.event_participants FOR DELETE
  USING (auth.uid() = profile_id);

-- User Interests
ALTER TABLE public.user_interests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Interests: owner read"
  ON public.user_interests FOR SELECT
  USING (auth.uid() = profile_id);

CREATE POLICY "Interests: owner insert"
  ON public.user_interests FOR INSERT
  WITH CHECK (auth.uid() = profile_id);

CREATE POLICY "Interests: owner update"
  ON public.user_interests FOR UPDATE
  USING (auth.uid() = profile_id);

CREATE POLICY "Interests: owner delete"
  ON public.user_interests FOR DELETE
  USING (auth.uid() = profile_id);


-- 7. SEED DATA — Initial categories
-- -----------------------------------------------------------------
INSERT INTO public.categories (name, slug, icon, sort_order) VALUES
  ('Concerts',    'concerts',    '🎵', 1),
  ('Sports',      'sports',      '⚽', 2),
  ('Stand-Up',    'standup',     '😆', 3),
  ('Business',    'business',    '💼', 4),
  ('Kids',        'kids',        '👶', 5),
  ('Theatre',     'theatre',     '🎭', 6),
  ('Festivals',   'festivals',   '🎪', 7),
  ('Art',         'art',         '🎨', 8)
ON CONFLICT (slug) DO NOTHING;

-- Common tags
INSERT INTO public.tags (name, slug) VALUES
  ('football',    'football'),
  ('basketball',  'basketball'),
  ('networking',  'networking'),
  ('comedy',      'comedy'),
  ('live-music',  'live-music'),
  ('electronic',  'electronic'),
  ('hip-hop',     'hip-hop'),
  ('opera',       'opera'),
  ('family',      'family'),
  ('outdoor',     'outdoor'),
  ('free',        'free'),
  ('workshop',    'workshop')
ON CONFLICT (slug) DO NOTHING;

```

