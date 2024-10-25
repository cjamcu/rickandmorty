import 'package:flutter/material.dart';

import 'package:rickandmorty/features/characters/domain/entities/episode.dart';
import 'package:rickandmorty/features/characters/domain/repositories/characters_repository.dart';

enum DetailCharacterState {
  initial,
  loading,
  loaded,
  error,
}

class DetailCharacterProvider extends ChangeNotifier {
  final CharactersRepository repository;

  DetailCharacterProvider({required this.repository});

  Episode? _episode;
  DetailCharacterState _state = DetailCharacterState.initial;

  Episode? get episode => _episode;
  DetailCharacterState get state => _state;

  Future<void> loadEpisode(String? url) async {
    if (url == null) return;

    _state = DetailCharacterState.loading;

    notifyListeners();

    try {
      _episode = await repository.getEpisode(url);
      _state = DetailCharacterState.loaded;
    } catch (e) {
      _state = DetailCharacterState.error;
    }
    notifyListeners();
  }
}
