import 'package:cinemapedia_app/config/theme/theme_context.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final colors = getColorScheme(context);
    final titleStyle = getTextTheme(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              Icon(Icons.movie_outlined, color: colors.primary, size: 30,),

              const SizedBox(width: 5,),

              Text('Cinemapedia', style: titleStyle.titleMedium,),
              
              const Spacer(),
              
              IconButton(
                onPressed: ()  {

                   //final movieRepository = ref.read(movieRepositoryProvider); 
                   final searchQuery = ref.read(searchQueryProvider);
                   final searchedMovies = ref.read(searchedMoviesProvider);

                   showSearch<Movie?>(
                      query: searchQuery,
                      context: context, 
                      delegate: SearchMovieDelegate(
                        initialMovies: searchedMovies,
                        searchMovies: ref.read( searchedMoviesProvider.notifier ).searchMoviesByQuery,
                        ref: ref
                      )
                    ).then((movie){

                      if (movie == null) return;

                      if(!context.mounted) return;
                      
                      context.push('/movie/${ movie.id }');

                    });

                    

                }, 
                icon: Icon(Icons.search, color: colors.primary,)
              )
            ],
          ),
        )
      )
      );
  }
}