import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/auth/auth_service.dart';
import 'package:go_router/go_router.dart';

class OriginCountryScreen extends ConsumerWidget {
  const OriginCountryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                'Откуда вы?',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Это поможет нам подобрать события вашей диаспоры.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: ListView(
                  children: [
                    _CountryTile(
                      label: 'Украина 🇺🇦',
                      onTap: () => _selectCountry(context, ref, 'Ukraine'),
                    ),
                    _CountryTile(
                      label: 'Казахстан 🇰🇿',
                      onTap: () => _selectCountry(context, ref, 'Kazakhstan'),
                    ),
                    _CountryTile(
                      label: 'Грузия 🇬🇪',
                      onTap: () => _selectCountry(context, ref, 'Georgia'),
                    ),
                    _CountryTile(
                      label: 'Армения 🇦🇲',
                      onTap: () => _selectCountry(context, ref, 'Armenia'),
                    ),
                    // More countries can be added or fetched from DB
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectCountry(
    BuildContext context,
    WidgetRef ref,
    String country,
  ) async {
    try {
      await ref.read(authServiceProvider).updateProfile(originCountry: country);
      if (context.mounted) {
        context.push('/onboarding/city');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка сохранения: $e')));
      }
    }
  }
}

class _CountryTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CountryTile({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white54),
            ],
          ),
        ),
      ),
    );
  }
}
