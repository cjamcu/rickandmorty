import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/features/characters/domain/usecases/find_characters.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(http.Client()));

  getIt.registerLazySingleton(() => FindCharacters(
        getIt(),
      ));

  getIt.registerFactory(() => CharactersBloc(
        getIt(),
      ));
}
