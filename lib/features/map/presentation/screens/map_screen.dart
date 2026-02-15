import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';
import 'package:global_diaspora_events/features/events/domain/models/event.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(
    52.5200,
    13.4050,
  ); // Berlin fallback

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      body: eventsAsync.when(
        data: (events) {
          final markers = _createMarkers(events, context);
          return GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Map Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: _initialPosition, zoom: 12),
            ),
          );
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Set<Marker> _createMarkers(List<Event> events, BuildContext context) {
    return events.where((e) => e.latitude != null && e.longitude != null).map((
      event,
    ) {
      return Marker(
        markerId: MarkerId(event.id),
        position: LatLng(event.latitude!, event.longitude!),
        infoWindow: InfoWindow(
          title: event.title,
          snippet: event.venueName,
          onTap: () {
            context.push('/events/${event.id}', extra: event);
          },
        ),
      );
    }).toSet();
  }
}
