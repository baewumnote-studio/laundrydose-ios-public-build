import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/l10n.dart';
import '../calculator/dose_page.dart';
import '../detergents/detergents_page.dart';
import '../history/history_page.dart';
import '../settings/settings_page.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});
  @override
  ConsumerState<AppShell> createState() => _S();
}

class _S extends ConsumerState<AppShell> {
  int index = 0;
  @override
  Widget build(BuildContext c) {
    final l = c.l10n;
    final pages = [
      const DosePage(),
      DetergentsPage(onUse: () => setState(() => index = 0)),
      const HistoryPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.water_drop_outlined),
            selectedIcon: const Icon(Icons.water_drop),
            label: l.tabDose,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_laundry_service_outlined),
            selectedIcon: const Icon(Icons.local_laundry_service),
            label: l.tabDetergents,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: l.tabHistory,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l.tabSettings,
          ),
        ],
      ),
    );
  }
}
