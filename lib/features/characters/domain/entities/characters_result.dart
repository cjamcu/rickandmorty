import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';

class CharactersResult extends Equatable {
  final List<Character> results;
  final int pages;
  final int count;

  const CharactersResult({
    required this.results,
    required this.pages,
    required this.count,
  });

  @override
  List<Object?> get props => [results, pages, count];

  CharactersResult copyWith({
    List<Character>? results,
    int? pages,
    int? count,
  }) {
    return CharactersResult(
      results: results ?? this.results,
      pages: pages ?? this.pages,
      count: count ?? this.count,
    );
  }
}
