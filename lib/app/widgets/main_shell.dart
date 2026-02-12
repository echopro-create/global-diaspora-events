import 'package:flutter/material.dart';
import 'package:gde/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// Shell-обёртка с BottomNavigationBar для основных разделов.
class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          indicatorColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.15),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined),
              selectedIcon: const Icon(Icons.explore_rounded),
              label: AppLocalizations.of(context)!.navDiscover,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search_outlined),
              selectedIcon: const Icon(Icons.search_rounded),
              label: AppLocalizations.of(context)!.navSearch,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bookmark_border_rounded),
              selectedIcon: const Icon(Icons.bookmark_rounded),
              label: AppLocalizations.of(context)!.myEvents,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: const Icon(Icons.person_rounded),
              label: AppLocalizations.of(context)!.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
