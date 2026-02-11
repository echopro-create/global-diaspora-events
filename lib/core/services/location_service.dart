import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Сервис геолокации.
///
/// Обёртка над `geolocator` для запроса разрешений
/// и получения текущей позиции.
class LocationService {
  /// Проверить и запросить разрешение на геолокацию.
  ///
  /// Возвращает `true` если разрешение получено.
  Future<bool> requestPermission() async {
    // Проверяем, включены ли сервисы геолокации
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('⚠ Location services are disabled.');
      return false;
    }

    // Проверяем текущий статус пермишена
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('⚠ Location permission denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('⚠ Location permission permanently denied.');
      return false;
    }

    return true;
  }

  /// Получить текущую позицию.
  ///
  /// Автоматически запрашивает разрешение если оно не было выдано ранее.
  /// Возвращает `null` если нет доступа к геолокации.
  Future<Position?> getCurrentPosition() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      debugPrint('❌ Failed to get position: $e');
      return null;
    }
  }

  /// Проверить текущий статус разрешения.
  Future<LocationPermission> checkPermission() async {
    return Geolocator.checkPermission();
  }

  /// Открыть настройки приложения (если пермишен отклонён навсегда).
  Future<bool> openSettings() async {
    return Geolocator.openAppSettings();
  }
}
