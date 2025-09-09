
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
  Future<List<Movie>> loadAllFavorites({int limit = 10, int offset = 0}) {
    // TODO: implement loadAllFavorites
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }
}