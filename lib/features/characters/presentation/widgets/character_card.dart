import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              width: 120,
              height: 120,
              imageUrl: character.image,
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) => const SizedBox(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider),
                ),
              ),
            ),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBadge(
                  text: character.origin,
                  iconPath: 'assets/icons/location.svg',
                  color: AppColors.pink,
                ),
                const SizedBox(width: 24),
                CustomBadge(
                  text: character.status,
                  iconPath: 'assets/icons/heart.svg',
                  color: character.status == 'Alive'
                      ? AppColors.green500
                      : AppColors.red400,
                ),
              ],
            ),
            const SizedBox(height: 32),
            TextGradientButton(
              text: 'Ver perfil',
              onPressed: () {},
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
