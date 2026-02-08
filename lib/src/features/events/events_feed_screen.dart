import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_diaspora_events/src/features/events/widgets/event_card.dart';
import 'package:global_diaspora_events/src/shared/models/event.dart';

class EventsFeedScreen extends ConsumerWidget {
  const EventsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text(
              'Global Diaspora',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Для вас',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: _buildShortCard(context),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'События рядом',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return EventCard(
                  event: _mockEvent(),
                  onTap: () {},
                  onJoinTap: () {},
                );
              }, childCount: 5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/300x150'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stand-up Charity Night',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Завтра, 19:00',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Event _mockEvent() {
    return Event(
      id: '1',
      title: 'Charity Stand-up Night',
      categoryId: '2',
      startTime: DateTime.now().add(const Duration(days: 1)),
      address: 'Berlin, Kulturbrauerei',
      imageUrl:
          'https://images.unsplash.com/photo-1514525253361-bee0438d7df3?q=80&w=300&auto=format&fit=crop',
      isPromoted: true,
      participantsCount: 124,
      isUserJoined: false,
    );
  }
}
