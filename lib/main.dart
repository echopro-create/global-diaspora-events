import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/constants/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Проверка конфигурации Supabase
  if (!SupabaseConfig.isConfigured) {
    debugPrint(
      '⚠ SUPABASE_URL и SUPABASE_ANON_KEY не заданы!\n'
      'Запустите приложение с флагами --dart-define:\n'
      '  flutter run '
      '--dart-define=SUPABASE_URL=https://xxx.supabase.co '
      '--dart-define=SUPABASE_ANON_KEY=eyJ...',
    );
  }

  // Инициализация Supabase
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
  }

  runApp(const ProviderScope(child: App()));
}
