import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_badges.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onPressed;
  final bool hideBadges;
  final bool enableHero;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onPressed,
    this.hideBadges = false,
    this.enableHero = true,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = GestureDetector(
      onTap: onPressed,
      child: AvatarCached(
        size: 120,
        imageUrl: character.image,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            enableHero
                ? Hero(
                    tag: character.id,
                    child: imageWidget,
                  )
                : imageWidget,
            const SizedBox(height: 20),
            Text(
              character.name,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              character.species.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.grey,
                  ),
            ),
            if (!hideBadges)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CharacterBadges(
                  mainAxisAlignment: MainAxisAlignment.center,
                  character: character,
                  separatorWidth: 24,
                ),
              ),
            const SizedBox(height: 32),
            TextGradientButton(
              text: 'Ver perfil',
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
