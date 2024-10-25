import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/screens/detail_character_screen.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/listview_infinite.dart';

class CharactersListView extends StatelessWidget {
  final List<Character> characters;
  final VoidCallback onEndOfList;
  final bool isLoadingMore;

  const CharactersListView({
    super.key,
    required this.characters,
    required this.onEndOfList,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListViewInfinite(
      shrinkWrap: true,
      itemCount: characters.length,
      onEndOfList: (_) => onEndOfList(),
      isLoadingMore: isLoadingMore,
      separatorBuilder: (context, index) => const SizedBox(height: 42),
      itemBuilder: (context, index) {
        return CharacterCard(
          character: characters[index],
          onPressed: () => Navigator.push(
            context,
            DetailCharacterScreen.route(
              characters[index],
              characters,
            ),
          ),
        );
      },
    );
  }
}
