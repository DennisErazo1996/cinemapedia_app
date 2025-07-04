import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/presentation/providers/providers.dart';
import 'package:cinemapedia_app/config/theme/theme_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(movie: movie),
          /*SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height
              ),
              child:  Material(
                elevation: 7,
                borderRadius: const BorderRadius.only(
                  topLeft:  Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                child: _MovieDetails(movie: movie) ,
              ), 
            ),
          )*/

          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) => _MovieDetails(movie: movie),
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = getScreenSize(context);

    const bool isSelected = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title,
                          style: getTextTheme(context).titleLarge),
                      Text(
                        movie.overview,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      backgroundColor: getColorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: Text(
                        gender,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                        if(loadingProgress != null) return const SizedBox(); 
                        return FadeIn(child: child);
                      },
                      actor.profilePath,
                      fit: BoxFit.cover,
                      height: 180,
                      width: 135,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, overflow: TextOverflow.fade),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: getColorScheme(context).primary,
      expandedHeight: getScreenSize(context).height * 0.7,
      foregroundColor: Colors.white,
      pinned: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(
            left: 20,
            bottom: 20,
          ),
          // title: Text(
          //   movie.title,
          //   style: getTextTheme(context).titleLarge?.copyWith(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500,
          //       ),
          //   textAlign: TextAlign.start,
          // ),
          background: Stack(
            children: [
              SizedBox.expand(
                  child: Image.network(
                    loadingBuilder: (context, child, loadingProgress) {

                      if(loadingProgress != null) return const SizedBox();
                      return FadeIn(child:  ZoomIn(
                        delay: const Duration(milliseconds: 50),
                        child: child));
                    },
                movie.posterPath,
                fit: BoxFit.cover,
              )),
              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.7, 0.9],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 1],
                      begin: Alignment.topLeft,
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
