
import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository{

  final LocalStorageDatasource localStorageDatasource;

  LocalStorageRepositoryImpl(this.localStorageDatasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return localStorageDatasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadAllFavorites({int limit = 10, int offset = 0}) {
    return localStorageDatasource.loadAllFavorites(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return localStorageDatasource.toggleFavorite(movie);
  }
}