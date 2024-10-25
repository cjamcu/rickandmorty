import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/screens/detail_character_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screens/search_screen.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/search_input.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  // Fake Characters of the Rick and Morty API
  static const List<Character> characters = [
    Character(
      id: 1,
      name: 'Rick',
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      gender: 'Male',
      species: 'Human',
      status: 'Alive',
      origin: 'Earth (C-500A)',
      created: '2017-11-10T13:08:13.191Z',
      episode: 'The Rickshank Rickdemption',
    ),
    Character(
      id: 37,
      name: 'Abadabgo Cluster Princess',
      image: 'https://rickandmortyapi.com/api/character/avatar/4.jpeg',
      gender: 'Female',
      species: 'Alien',
      status: 'Died',
      origin: 'Abadabgo Cluster',
      created: '2017-11-04T18:48:46.250Z',
      episode: 'The Rickshank Rickdemption',
    ),
  ];

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => const CharactersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Color(0xffF5F5F5),
              size: 24,
            ),
            label: Text(
              'Salir',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xffF5F5F5),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            iconAlignment: IconAlignment.end,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black700,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              SearchInput(
                readOnly: true,
                hintText: 'Buscar personaje',
                onTap: () => Navigator.push(
                  context,
                  SearchScreen.route(),
                ),
              ),
              const SizedBox(height: 40),
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: characters.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 42),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
