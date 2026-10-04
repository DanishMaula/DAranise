import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/custom_floating_tab_bar.dart';

class MainNavigationPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationPage({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: CustomFloatingTabBar(
          selectedIndex: navigationShell.currentIndex,
          onTabSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}

