import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:cinemapedia_app/presentation/view/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        // Branch para Home/Movies
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: HomeView(),
                );                
              },
            ),
          ],
        ),
        // Branch para Categories/Popular
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text('Categorías - Próximamente')),
                ),
              ),
            ),
          ],
        ),
        // Branch para Favorites
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: FavoritesView(),
              ),
            ),
          ],
        ),
      ],
    ),
    // Ruta independiente para detalles de película
    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(movieId: movieId);
      },
    ),
  ],
);
