import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../core/theme/app_colors.dart';

/// City selection screen - выбор города проживания
class CitySelectionScreen extends ConsumerStatefulWidget {
  const CitySelectionScreen({super.key});

  @override
  ConsumerState<CitySelectionScreen> createState() =>
      _CitySelectionScreenState();
}

class _CitySelectionScreenState extends ConsumerState<CitySelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customCityController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCity;
  bool _showCustomInput = false;

  // Популярные города Европы для диаспор
  static const List<String> _cities = [
    'Paris',
    'London',
    'Berlin',
    'Madrid',
    'Rome',
    'Amsterdam',
    'Brussels',
    'Vienna',
    'Warsaw',
    'Prague',
    'Munich',
    'Barcelona',
    'Milan',
    'Frankfurt',
    'Hamburg',
    'Stockholm',
    'Copenhagen',
    'Dublin',
    'Lisbon',
    'Athens',
  ];

  List<String> get _filteredCities {
    if (_searchQuery.isEmpty) return _cities;
    return _cities
        .where((c) => c.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _customCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your City'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Where do you live?',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find events near you',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 24),

              // Search field
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search city...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _showCustomInput = false;
                    });
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Cities list
              Expanded(
                child: _showCustomInput
                    ? _buildCustomCityInput()
                    : ListView.builder(
                        itemCount: _filteredCities.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _filteredCities.length) {
                            // "Other city" option
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GlassContainer(
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  leading: const Icon(Icons.add_location),
                                  title: const Text('Other city...'),
                                  onTap: () {
                                    setState(() {
                                      _showCustomInput = true;
                                    });
                                  },
                                ),
                              ),
                            );
                          }

                          final city = _filteredCities[index];
                          final isSelected = _selectedCity == city;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GlassContainer(
                              padding: const EdgeInsets.all(0),
                              child: ListTile(
                                leading: const Icon(Icons.location_city),
                                title: Text(
                                  city,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                trailing: isSelected
                                    ? Icon(
                                        Icons.check_circle,
                                        color: AppColors.accentBlue,
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    _selectedCity = city;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedCity == null
                      ? null
                      : () {
                          // TODO: Save city to onboarding controller
                          context.push('/onboarding/interests');
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomCityInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _customCityController,
            decoration: const InputDecoration(
              hintText: 'Enter your city name',
              prefixIcon: Icon(Icons.edit_location),
              border: InputBorder.none,
            ),
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _selectedCity = value.isNotEmpty ? value : null;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _showCustomInput = false;
              _customCityController.clear();
              _selectedCity = null;
            });
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back to list'),
        ),
      ],
    );
  }
}
