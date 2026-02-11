import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';

/// Provider для LocationService (singleton).
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

/// Provider для текущей позиции пользователя.
///
/// Запрашивает разрешение и возвращает координаты.
/// Вернёт `null` если пользователь отказал в доступе.
final currentPositionProvider = FutureProvider<Position?>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentPosition();
});
