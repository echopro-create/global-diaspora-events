import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_diaspora_events/generated/l10n/app_localizations.dart';
import 'package:global_diaspora_events/core/constants/app_constants.dart';
import 'package:global_diaspora_events/core/theme/app_theme.dart';
import 'package:global_diaspora_events/core/router/app_router.dart';
import 'package:global_diaspora_events/features/notifications/presentation/providers/notification_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (wrapped in try-catch as config files might be missing initially)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint(
      'Firebase initialization failed: $e. Make sure to add google-services.json/GoogleService-Info.plist',
    );
  }

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize notifications
    // We use a post-frame callback or just run it, effectively firing and forgetting for init
    // But since it's async and we want it to run, we can just call it.
    // Using ref.read is safe in initState if we don't watch.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationServiceProvider).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Global Diaspora Events',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
