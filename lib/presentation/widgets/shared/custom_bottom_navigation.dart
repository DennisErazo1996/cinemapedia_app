import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({super.key, required this.navigationShell});

  void onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: navigationShell.currentIndex,
      onTap: onItemTapped,
      elevation: 0,
      items: [

        BottomNavigationBarItem(
          icon: const Icon(Icons.home_max_rounded), 
          activeIcon: const Icon(Icons.home, color: Colors.white),
          label: 'Inicio',
          backgroundColor: colors.primary
        ),

        BottomNavigationBarItem(
          icon: const Icon(Icons.label_outline_rounded), 
          activeIcon: const Icon(Icons.label, color: Colors.white),
          label: 'Categorías',
          backgroundColor: colors.secondary
        ),

        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_outline_rounded), 
          activeIcon: const Icon(Icons.favorite, color: Colors.white),
          label: 'Favoritos',
          backgroundColor: colors.tertiary
        ),
        
      ]);
  }
}