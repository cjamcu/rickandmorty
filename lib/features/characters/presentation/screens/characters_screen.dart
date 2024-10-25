import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/characters/data/datasources/characters_datasource.dart';
import 'package:rickandmorty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/presentation/providers/characters_provider.dart';
import 'package:rickandmorty/features/characters/presentation/screens/search_screen.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/characters_list_view.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/gradient_button.dart';
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
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
        child: Column(
          children: [
            ChangeNotifierProvider<CharactersProvider>(
              create: (context) => CharactersProvider(
                charactersRepository: CharactersRepositoryImpl(
                  charactersDatasource:
                      CharactersDatasourceApi(client: Client()),
                ),
              )..getCharacters(),
              child: const _CharactersContent(),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}

class _CharactersContent extends StatelessWidget {
  const _CharactersContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, provider, child) {
        switch (provider.status) {
          case CharactersProviderStatus.loading:
            return const _LoadingIndicator();
          case CharactersProviderStatus.error:
            return _ErrorView(onRetry: () => provider.getCharacters());
          case CharactersProviderStatus.success:
          case CharactersProviderStatus.loadingMore:
            return _CharactersListView(provider: provider);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.mediumSpringGreen,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
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
          onPressed: onRetry,
        ),
      ],
    );
  }
}

class _CharactersListView extends StatelessWidget {
  final CharactersProvider provider;

  const _CharactersListView({required this.provider});

  @override
  Widget build(BuildContext context) {
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
            child: CharactersListView(
              characters: characters,
              onEndOfList: () => provider.getCharacters(
                page: provider.page + 1,
              ),
              isLoadingMore:
                  provider.status == CharactersProviderStatus.loadingMore,
            ),
          ),
        ],
      ),
    );
  }
}
