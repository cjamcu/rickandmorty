import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => SearchScreen(),
      );

  final List<Character> foundCharacters = [
    const Character(
      id: 1,
      name: 'Benet Sanchez',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      status: 'Alive',
      species: 'Human',
      gender: 'Male',
      origin: '',
      created: '',
      episode: '',
    ),
    const Character(
      id: 2,
      name: 'Morty Smith',
      image: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      status: 'Alive',
      species: 'Human',
      gender: 'Male',
      origin: '',
      created: '',
      episode: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 22,
            right: 26,
          ),
          child: Column(
            children: [
              SearchInput(
                autofocus: true,
                hintText: 'Buscar personaje',
                onChanged: (value) => {},
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 41),
                  Image.asset(
                    'assets/images/search_empty.png',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Escribe el nombre de un personaje para empezar a buscar',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: ListView.builder(
                  itemCount: foundCharacters.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        AvatarCached(
                          imageUrl: foundCharacters[index].image,
                          size: 60,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foundCharacters[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(foundCharacters[index].species.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.grey,
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
