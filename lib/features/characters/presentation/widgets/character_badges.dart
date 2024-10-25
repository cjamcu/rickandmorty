import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class CharacterBadges extends StatelessWidget {
  final Character character;
  final double separatorWidth;
  final MainAxisAlignment mainAxisAlignment;

  const CharacterBadges({
    super.key,
    required this.character,
    this.separatorWidth = 7,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        CustomBadge(
          text: character.origin,
          iconPath: 'assets/icons/location.svg',
          color: AppColors.pink,
        ),
        SizedBox(width: separatorWidth),
        CustomBadge(
          text: character.status,
          iconPath: 'assets/icons/heart.svg',
          color: character.status == 'Alive'
              ? AppColors.green500
              : AppColors.red400,
        ),
      ],
    );
  }
}
