import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/presentation/providers/search_characters_provider.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/search_results_list.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/search_state_message.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const SearchScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchCharactersProvider(
        charactersRepository: CharactersRepositoryImpl(
          charactersDatasource: CharactersDatasourceApi(client: http.Client()),
        ),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 22, right: 26),
            child: Column(
              children: [
                _SearchBar(),
                SizedBox(height: 20),
                Expanded(child: _SearchContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SearchCharactersProvider>(context, listen: false);
    return SearchInput(
      autofocus: true,
      hintText: 'Buscar personaje',
      onChanged: provider.searchCharacters,
    );
  }
}

class _SearchContent extends StatelessWidget {
  const _SearchContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchCharactersProvider>(
      builder: (context, provider, _) {
        switch (provider.status) {
          case SearchCharactersStatus.initial:
            return const SearchStateMessage(
              imagePath: 'assets/images/search_empty.png',
              message:
                  'Escribe el nombre de un personaje para empezar a buscar',
            );
          case SearchCharactersStatus.loading:
            return const Center(
              child:
                  CircularProgressIndicator(color: AppColors.mediumSpringGreen),
            );
          case SearchCharactersStatus.success:
            return SearchResultsList(characters: provider.foundCharacters);
          case SearchCharactersStatus.emptyResults:
            return const SearchStateMessage(
              imagePath: 'assets/images/search_empty.png',
              message: 'No se encontraron resultados',
            );
          case SearchCharactersStatus.error:
            return const SearchStateMessage(
              message: 'Error al buscar personajes',
            );
        }
      },
    );
  }
}
