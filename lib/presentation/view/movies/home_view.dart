
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme/theme_context.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topratedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(), 
      slivers: [

      SliverAppBar(
        foregroundColor: getColorScheme(context).onPrimary,
        floating: true,
        flexibleSpace:  const CustomAppbar(),

      ),
      
      SliverList(delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              //const CustomAppbar(),
              MoviesSlideshow(movies: moviesSlideshow),

              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes 20',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),

              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Próximamente',
                subTitle: 'En cines',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),

              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                subTitle: 'Top',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),

              MovieHorizontalListview(
                movies: topratedMovies,
                title: 'Mejores calificadas',
                subTitle: 'Desde siempre',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),


             
              /*Expanded(
                child: ListView.builder(
                  itemCount: nowPlayingMovies.length,
                  itemBuilder: (context, index) {
      
                    final movie = nowPlayingMovies[index];
      
                    return ListTile(
                      title: Text(movie.title),
                    );
                  
                  },        
                ),
              )*/
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
