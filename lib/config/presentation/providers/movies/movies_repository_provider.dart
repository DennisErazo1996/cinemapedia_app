

import 'package:cinemapedia_app/config/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_app/config/infrastructure/repositories/movie_repositoty_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieReposoryProvider = Provider((ref) {
    return MovieRepositoryImpl( MoviedbDatasource() );
});