import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_cache_image.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final GestureTapCallback onTap;

  const CharacterCard({Key? key, required this.character, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: CharacterCacheImage(
                imageUrl: character.image,
                heroTag: character.id,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(character.name),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: character.status == "Alive"
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(character.status),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
