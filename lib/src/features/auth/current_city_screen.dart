import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:global_diaspora_events/src/core/app_colors.dart';
import 'package:global_diaspora_events/src/features/auth/auth_service.dart';

class CurrentCityScreen extends ConsumerWidget {
  const CurrentCityScreen({super.key});

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
                'Где вы сейчас?',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Чтобы показать события неподалеку от вас.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 48),
              _ActionButton(
                label: 'Использовать GPS',
                icon: Icons.my_location,
                onTap: () => _useGPS(context, ref),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('ИЛИ', style: TextStyle(color: Colors.white24)),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск города...',
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  filled: true,
                  fillColor: AppColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) => _selectCity(context, ref, value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _useGPS(BuildContext context, WidgetRef ref) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Службы геолокации отключены')),
          );
        }
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      final position = await Geolocator.getCurrentPosition();

      // Сохраняем координаты в формате GeoJSON для PostGIS
      final location = {
        'type': 'Point',
        'coordinates': [position.longitude, position.latitude],
      };

      await ref.read(authServiceProvider).updateProfile(location: location);

      if (context.mounted) {
        context.push('/onboarding/spotify');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка GPS: $e')));
      }
    }
  }

  void _selectCity(BuildContext context, WidgetRef ref, String city) async {
    try {
      // Здесь мы просто сохраняем название города.
      // В будущем можно добавить поиск координат по названию.
      await ref
          .read(authServiceProvider)
          .updateProfile(
            fullName: city,
          ); // Используем fullName как временное хранилище или добавим поле city

      if (context.mounted) {
        context.push('/onboarding/spotify');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка сохранения города: $e')));
      }
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
