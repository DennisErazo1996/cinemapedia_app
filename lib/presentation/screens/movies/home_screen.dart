import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {

  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  static const name = 'home-screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(navigationShell: navigationShell),
    );
  }
}
