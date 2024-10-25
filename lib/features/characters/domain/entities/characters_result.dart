import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class CharactersResult {
  final List<Character> results;
  final int pages;
  final int count;

  const CharactersResult({
    required this.results,
    required this.pages,
    required this.count,
  });
}
