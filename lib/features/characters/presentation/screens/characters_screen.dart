import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/presentation/providers/characters_provider.dart';
import 'package:rickandmorty/features/characters/presentation/screens/detail_character_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screens/search_screen.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/gradient_button.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/listview_infinite.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/search_input.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 40,
        ),
        child: Column(
          children: [
            ChangeNotifierProvider<CharactersProvider>(
              create: (context) => CharactersProvider(
                charactersRepository: CharactersRepositoryImpl(
                  charactersDatasource:
                      CharactersDatasourceApi(client: Client()),
                ),
              )..getCharacters(),
              child: Consumer<CharactersProvider>(
                builder: (context, provider, child) {
                  if (provider.status == CharactersProviderStatus.error) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error al cargar los personajes. Intenta nuevamente.',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextGradientButton(
                          text: 'Reintentar',
                          onPressed: () => provider.getCharacters(),
                        ),
                      ],
                    );
                  }
                  if (provider.status == CharactersProviderStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mediumSpringGreen,
                      ),
                    );
                  }
                  if (provider.status == CharactersProviderStatus.success ||
                      provider.status == CharactersProviderStatus.loadingMore) {
                    final characters = provider.charactersResult.results;
                    return Expanded(
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
                          Expanded(
                            child: ListViewInfinite(
                              shrinkWrap: true,
                              itemCount: characters.length,
                              onEndOfList: (value) {
                                provider.getCharacters(
                                  page: provider.page + 1,
                                );
                              },
                              isLoadingMore: provider.status ==
                                  CharactersProviderStatus.loadingMore,
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
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
