

import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/config/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/config/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));

  List<Movie> _jsonToMovieList(Map<String, dynamic> json) {

    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1})  async{

    final response = await dio.get('/movie/now_playing', queryParameters: { 'page': page });
    
  
    return _jsonToMovieList(response.data);

  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {

    final response = await dio.get('/movie/popular', queryParameters: { 'page': page });

    
    return _jsonToMovieList(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: { 'page': page });

    
    return _jsonToMovieList(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
    final response = await dio.get('/movie/upcoming', queryParameters: { 'page': page });

    
    return _jsonToMovieList(response.data);
  }

  


}