import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class CharactersInfo extends Equatable {
  final List<Character> characters;
  final int totalPages;
  final int currentPage;

  const CharactersInfo({
    required this.characters,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [characters, totalPages, currentPage];
}
