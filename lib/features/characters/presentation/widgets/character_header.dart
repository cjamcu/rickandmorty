import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class CharacterHeader extends StatelessWidget {
  final Character character;

  const CharacterHeader({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Hero(
              tag: character.id,
              child: AvatarCached(
                imageUrl: character.image,
                size: 181,
              ),
            ),
            const SizedBox(width: 32.5),
            GradientContainer(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 9,
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Text(
                  character.id.toString(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          character.name,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.white,
              ),
        ),
      ],
    );
  }
}
