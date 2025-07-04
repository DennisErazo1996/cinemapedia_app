

import 'package:cinemapedia_app/config/domain/entities/actor.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getActorsByMovie(String movieId);

}
