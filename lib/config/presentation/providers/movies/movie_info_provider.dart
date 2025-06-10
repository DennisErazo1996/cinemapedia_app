
import 'package:cinemapedia_app/config/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapProvider, Map<String, Movie>>((ref) {

    final infoMovies = ref.watch( movieReposoryProvider ).getMovieById;

    return MovieMapProvider(
      getMovie: infoMovies
    );

});


typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapProvider extends StateNotifier<Map<String, Movie>> {
  GetMovieCallback getMovie;
  
  MovieMapProvider({required this.getMovie}) : super({});


  Future<void> loadMovie(String movieId) async{
    if( state[movieId] != null ) return;
    //print('Loading movie: $movieId');
    
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }

  
}