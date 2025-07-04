import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {

  var selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: selectedIndex,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
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