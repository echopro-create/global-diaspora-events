import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../app/theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/event.dart';
import '../providers/events_providers.dart';

/// Карта со всеми событиями (маркерами).
class EventsMapScreen extends ConsumerStatefulWidget {
  const EventsMapScreen({super.key});

  @override
  ConsumerState<EventsMapScreen> createState() => _EventsMapScreenState();
}

class _EventsMapScreenState extends ConsumerState<EventsMapScreen> {
  final MapController _mapController = MapController();
  Event? _selectedEvent;

  // Центр Европы по умолчанию (Берлин — много mock событий рядом)
  static const _defaultCenter = LatLng(52.52, 13.405);
  static const _defaultZoom = 5.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = AppColors.isDark(context);
    final eventsAsync = ref.watch(eventsProvider(null));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mapView),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: eventsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => Center(child: Text(l10n.failedToLoadEvent)),
        data: (events) {
          // Фильтруем только события с координатами
          final mapped = events
              .where((e) => e.latitude != null && e.longitude != null)
              .toList();

          return Stack(
            children: [
              // Карта
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _defaultCenter,
                  initialZoom: _defaultZoom,
                  onTap: (_, _) => setState(() => _selectedEvent = null),
                ),
                children: [
                  TileLayer(
                    urlTemplate: isDark
                        ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                        : 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.example.gde',
                  ),
                  // Маркеры
                  MarkerLayer(
                    markers: mapped
                        .map((event) => _buildMarker(event))
                        .toList(),
                  ),
                ],
              ),

              // Popup — выбранное событие
              if (_selectedEvent != null) _buildEventPopup(_selectedEvent!),
            ],
          );
        },
      ),
    );
  }

  Marker _buildMarker(Event event) {
    final isSelected = _selectedEvent?.id == event.id;
    return Marker(
      point: LatLng(event.latitude!, event.longitude!),
      width: isSelected ? 48 : 40,
      height: isSelected ? 48 : 40,
      child: GestureDetector(
        onTap: () => setState(() => _selectedEvent = event),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : event.isPromoted
                ? AppColors.accent
                : AppColors.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.event_rounded,
            color: Colors.white,
            size: isSelected ? 22 : 18,
          ),
        ),
      ),
    );
  }

  Widget _buildEventPopup(Event event) {
    final l10n = AppLocalizations.of(context)!;
    return Positioned(
      bottom: 24,
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () => context.push('/event/${event.id}'),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Иконка или мини-картинка
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.event_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              // Информация
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.adaptiveTextPrimary(context),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.venueName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.adaptiveTextSecondary(context),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.peopleGoing(event.participantsCount),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Стрелка
              const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
