import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/screens/detail_character_screen.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';

class MoreCharactersList extends StatelessWidget {
  final List<Character> characters;
  final Character character;
  const MoreCharactersList({
    super.key,
    required this.characters,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    // remove the character that is being displayed
    final charactersToDisplay =
        characters.where((c) => c.id != character.id).toList();

    charactersToDisplay.shuffle();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int index = 0; index < charactersToDisplay.length; index++)
            Padding(
              padding: EdgeInsets.only(
                right: index < charactersToDisplay.length - 1 ? 16 : 0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.78,
                child: CharacterCard(
                  character: charactersToDisplay[index],
                  enableHero: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      DetailCharacterScreen.route(
                          charactersToDisplay[index], characters),
                    );
                  },
                  hideBadges: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
