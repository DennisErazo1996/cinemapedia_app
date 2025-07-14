import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/human_formats.dart';
import 'package:cinemapedia_app/config/theme/theme_context.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  final WidgetRef ref;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.searchMovies,
      required this.initialMovies,
      required this.ref});

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();


    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if(query.isEmpty){
      //   ref.read(searchQueryProvider.notifier).update((state) => query);
      //   ref.read( searchedMoviesProvider.notifier ).searchMoviesByQuery(query);
      //   debouncedMovies.add([]);
      //   return;
      // }

      final movie = await searchMovies(query);
      initialMovies = movie;
      debouncedMovies.add(movie);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      //future: searchMovies(query),
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
            // return ListTile(
            //   title: Text(movie.title),
            // );
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar pelicula...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[

      StreamBuilder(
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          return snapshot.data == true
              ? SpinPerfect(
                  infinite: true,
                  duration: const Duration(seconds: 5),
                  animate: query.isNotEmpty,
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.refresh_outlined)),
                )
              : ZoomIn(
                  animate: query.isNotEmpty,
                  child: IconButton(
                      onPressed: () => query = '',
                      icon: const Icon(Icons.clear_rounded)),
                );
        },
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = getTextTheme(context);
    final screenSize = getScreenSize(context);

    return GestureDetector(
      onTap: () {
        //onMovieSelected(context, movie);
        context.push('/movie/${movie.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: screenSize.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  Text(
                    movie.overview,
                    overflow: TextOverflow.fade,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.amber[600],
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.amber[800]),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
