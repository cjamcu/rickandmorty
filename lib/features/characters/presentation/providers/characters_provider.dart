import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/characters_result.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

enum CharactersProviderStatus {
  initial,
  loading,
  loadingMore,
  success,
  error,
}

class CharactersProvider extends ChangeNotifier {
  final CharactersRepository charactersRepository;

  CharactersProvider({required this.charactersRepository});

  CharactersResult _charactersResult = const CharactersResult(
    results: [],
    pages: 0,
    count: 0,
  );

  CharactersResult get charactersResult => _charactersResult;

  int _page = 1;

  int get page => _page;

  CharactersProviderStatus _status = CharactersProviderStatus.initial;

  CharactersProviderStatus get status => _status;

  Future<void> getCharacters({int page = 1}) async {
    try {
      _status = page > 1
          ? CharactersProviderStatus.loadingMore
          : CharactersProviderStatus.loading;
      notifyListeners();
      final oldCharacters = _charactersResult.results;

      final charactersResult = await charactersRepository.getCharacters(
        page: page,
      );

      _charactersResult = charactersResult.copyWith(
        results: [...oldCharacters, ...charactersResult.results],
      );

      _page = page;
      _status = CharactersProviderStatus.success;
      notifyListeners();
    } catch (e) {
      _status = CharactersProviderStatus.error;
      notifyListeners();
    }
  }
}
