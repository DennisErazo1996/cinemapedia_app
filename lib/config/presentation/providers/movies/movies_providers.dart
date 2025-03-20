
import 'package:cinemapedia_app/config/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

    final fetchMoreMovies = ref.watch( movieReposoryProvider ).getNowPlaying;

    return MoviesNotifier(
      fetchMoreMovies: fetchMoreMovies
    );

});


typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int curretPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier(
   { required this.fetchMoreMovies}
  ) : super([]);

  Future<void> loadNextPage() async {
    
    curretPage++;
    final List<Movie> movies = await fetchMoreMovies(page: curretPage);
    state = [...state, ...movies];
    
  }

}