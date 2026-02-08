import 'package:flutter/material.dart';

class EventParticipationWidget extends StatelessWidget {
  final int participantsCount;
  final String originCountry;

  const EventParticipationWidget({
    super.key,
    required this.participantsCount,
    required this.originCountry,
  });

  @override
  Widget build(BuildContext context) {
    // В реальном приложении здесь был бы еще запрос: "сколько из них из твоей страны"
    // Для V1 используем заглушку с реалистичным дизайном
    final fromYourCountry = (participantsCount * 0.4)
        .round(); // Допустим, 40% из диаспоры

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Stack(
              children: [
                _buildAvatar(0, 'https://i.pravatar.cc/150?u=1'),
                Positioned(
                  left: 15,
                  child: _buildAvatar(1, 'https://i.pravatar.cc/150?u=2'),
                ),
                Positioned(
                  left: 30,
                  child: _buildAvatar(2, 'https://i.pravatar.cc/150?u=3'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$participantsCount человек идут',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$fromYourCountry из вашей диаспоры ($originCountry)',
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(int index, String url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: CircleAvatar(radius: 14, backgroundImage: NetworkImage(url)),
    );
  }
}
