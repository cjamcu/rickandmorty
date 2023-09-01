import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/features/characters/domain/usecases/find_characters.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rickandmorty/features/location_detail/domain/usecase/find_characters_by_location.dart';
import 'package:rickandmorty/features/location_detail/presentation/bloc/location_detail_bloc.dart';
import 'package:rickandmorty/features/locations/data/repositories/locations_repository_impl.dart';
import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';
import 'package:rickandmorty/features/locations/domain/usecase/find_locations.dart';
import 'package:rickandmorty/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:rickandmorty/features/shared/data/repositories/characters_repository_impl.dart';

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

  // Location detail page  injection
  getIt.registerLazySingleton(() => FindCharactersByLocation(
        getIt(),
      ));
  getIt.registerFactory(() => LocationDetailBloc(
        getIt(),
      ));
}
