import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/features/characters/domain/usecases/find_characters.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rickandmorty/features/episodes/data/repositories/episodes_repository_impl.dart';
import 'package:rickandmorty/features/episodes/domain/repositories/episodes_repository.dart';
import 'package:rickandmorty/features/episodes/domain/usecases/find_episodies.dart';
import 'package:rickandmorty/features/episodes/presentation/bloc/episodes_bloc.dart';

import 'package:rickandmorty/features/locations/data/repositories/locations_repository_impl.dart';
import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';
import 'package:rickandmorty/features/locations/domain/usecase/find_locations.dart';
import 'package:rickandmorty/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:rickandmorty/features/shared/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/shared/domain/usecase/find_characters_by_ids.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/characters_by_ids_widget/bloc/characters_by_ids_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => http.Client());

  // Characters page  injection
  getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => FindCharacters(
        getIt(),
      ));
  getIt.registerFactory(() => CharactersBloc(
        getIt(),
      ));

  // Locations page  injection

  getIt.registerLazySingleton<LocationsRepository>(
      () => LocationsRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => FindLocations(
        getIt(),
      ));
  getIt.registerFactory(() => LocationsBloc(
        getIt(),
      ));

  // CharactersByIds widget  injection
  getIt.registerLazySingleton(() => FindCharactersByIds(
        getIt(),
      ));
  getIt.registerFactory(() => CharactersByIdsBloc(
        getIt(),
      ));

  // Episodes page  injection
  getIt.registerLazySingleton<EpisodesRepository>(
      () => EpisodesRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => FindEpisodes(
        getIt(),
      ));
  getIt.registerFactory(() => EpisodesBloc(
        getIt(),
      ));
}
