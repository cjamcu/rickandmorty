import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/domain/exceptions/no_found_characters_exceptions.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

enum SearchCharactersStatus {
  initial,
  loading,
  success,
  error,
  emptyResults,
}

class SearchCharactersProvider extends ChangeNotifier {
  final CharactersRepository charactersRepository;

  SearchCharactersProvider({required this.charactersRepository});

  List<Character> _foundCharacters = [];
  List<Character> get foundCharacters => _foundCharacters;

  SearchCharactersStatus _status = SearchCharactersStatus.initial;
  SearchCharactersStatus get status => _status;

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  Future<void> searchCharacters(String query) async {
    if (query.isEmpty) {
      _foundCharacters = [];
      _status = SearchCharactersStatus.initial;
      notifyListeners();
      return;
    }

    try {
      _status = SearchCharactersStatus.loading;
      _searchTerm = query;
      notifyListeners();

      final charactersResult =
          await charactersRepository.getCharacters(name: query, page: 1);
      _foundCharacters = charactersResult.results;

      _status = SearchCharactersStatus.success;
      notifyListeners();
    } on NotFoundCharactersException {
      _status = SearchCharactersStatus.emptyResults;
      notifyListeners();
    } catch (e) {
      _status = SearchCharactersStatus.error;
      notifyListeners();
    }
  }
}
