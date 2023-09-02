import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/characters_grid.dart';
import 'package:rickandmorty/features/characters_detail/presentation/characters_detail_page.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/characters_by_ids_widget/bloc/characters_by_ids_bloc.dart';

import 'package:rickandmorty/injection_container.dart';

class CharactersByIds extends StatelessWidget {
  final List<int> characterIds;
  final String title;

  const CharactersByIds({
    Key? key,
    required this.characterIds,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CharactersByIdsBloc>()
        ..add(
          FindCharactersFromLocationEvent(charactersIDs: characterIds),
        ),
      child: BlocBuilder<CharactersByIdsBloc, CharactersByIdsState>(
        builder: (context, state) {
          if (state is LoadingCharactersState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final hasError = state is ErrorLoadingCharactersState;
          final hasCharacters = state.characters.isNotEmpty;

          if (hasError || !hasCharacters) {
            return const SizedBox.shrink();
          }

          return Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "$title (${state.characters.length})",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CharactersGrid(
                    characters: state.characters,
                    onTap: (character) {
                      Navigator.push(
                        context,
                        CharactersDetail.route(character),
                      );
                    }),
              ),
            ],
          ));
        },
      ),
    );
  }
}
