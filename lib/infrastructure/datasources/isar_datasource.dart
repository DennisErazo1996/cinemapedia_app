
import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatasource extends LocalStorageDatasource{

  late Future<Isar> db;

  IsarDatasource(){
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema], directory: './data', inspector: true
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadAllFavorites({int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if(favoriteMovie != null){
      isar.writeTxnSync(() => isar.movies.put(movie));
    }

    isar.writeTxnSync(() => isar.movies.delete(favoriteMovie!.isarId!));
  }

}