import 'package:flutter/cupertino.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';

class CharactersGrid extends StatelessWidget {
  final List<Character> characters;

  final ValueChanged<Character> onTap;

  const CharactersGrid(
      {Key? key, required this.characters, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 150,
      children: characters
          .map((character) => CharacterCard(
                character: character,
                onTap: () {
                  onTap(character);
                },
              ))
          .toList(),
    );
  }
}
