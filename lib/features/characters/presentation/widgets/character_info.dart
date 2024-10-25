import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_info_item.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;

  const CharacterInfo({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterInfoItem(
          label: 'Species',
          value: character.species,
        ),
        const SizedBox(height: 12),
        CharacterInfoItem(
          label: 'Created',
          value: character.created,
        ),
        const SizedBox(height: 12),
        CharacterInfoItem(
          label: 'Episode',
          value: character.episode,
        ),
      ],
    );
  }
}
