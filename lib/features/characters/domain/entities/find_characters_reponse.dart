import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class FindCharactersResponse extends Equatable {
  final List<Character> characters;
  final int totalPages;
  final int totalElements;

  const FindCharactersResponse({
    required this.characters,
    required this.totalPages,
    required this.totalElements,
  });

  @override
  List<Object?> get props => [characters, totalPages, totalElements];
}
