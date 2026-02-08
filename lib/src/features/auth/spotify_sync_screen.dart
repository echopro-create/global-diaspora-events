import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/auth/auth_service.dart';
import 'package:go_router/go_router.dart';

class SpotifySyncScreen extends ConsumerWidget {
  const SpotifySyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.audiotrack,
                size: 80,
                color: Color(0xFF1DB954),
              ), // Spotify Green
              const SizedBox(height: 32),
              Text(
                'Синхронизация со Spotify',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Мы импортируем ваших любимых артистов, чтобы вы не пропустили их концерты в вашей новой стране.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _syncSpotify(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1DB954),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.sync),
                  label: const Text(
                    'Подключить Spotify',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _skip(context),
                child: const Text(
                  'Пропустить',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _syncSpotify(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authServiceProvider).signInWithSpotify();
      // Вызываем завершение в зависимости от политики приложения (обычно слушаем auth state)
      if (context.mounted) {
        _completeOnboarding(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка Spotify: $e')));
      }
    }
  }

  void _skip(BuildContext context) {
    _completeOnboarding(context);
  }

  void _completeOnboarding(BuildContext context) {
    context.go('/feed');
  }
}
