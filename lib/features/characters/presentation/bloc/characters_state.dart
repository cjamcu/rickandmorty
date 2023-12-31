part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  final Model model;

  const CharactersState({required this.model});

  @override
  List<Object?> get props => [model];
}

class CharactersInitial extends CharactersState {
  const CharactersInitial(Model model)
      : super(
          model: model,
        );
}

class CharactersLoading extends CharactersState {
  const CharactersLoading(Model model)
      : super(
          model: model,
        );
}

class CharactersLoaded extends CharactersState {
  const CharactersLoaded(Model model)
      : super(
          model: model,
        );
}

class CharactersError extends CharactersState {
  const CharactersError(Model model)
      : super(
          model: model,
        );
}

class CharactersLoadingMore extends CharactersState {
  const CharactersLoadingMore(Model model)
      : super(
          model: model,
        );
}
class NoResultsFound extends CharactersState {
  const NoResultsFound(Model model)
      : super(
    model: model,
  );
}


class Model extends Equatable {
  final List<Character> characters;
  final int totalPages;
  final int currentPage;
  final int totalElements;

  const Model({
    required this.characters,
    required this.totalPages,
    required this.currentPage,
    required this.totalElements,
  });

  @override
  List<Object?> get props =>
      [characters, totalPages, currentPage, totalElements];

  copyWith({
    List<Character>? characters,
    int? totalPages,
    int? currentPage,
    int? totalElements,
  }) {
    return Model(
      characters: characters ?? this.characters,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalElements: totalElements ?? this.totalElements,
    );
  }
}
