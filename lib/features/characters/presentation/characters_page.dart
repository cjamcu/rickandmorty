import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/characters_grid.dart';
import 'package:rickandmorty/features/characters_detail/presentation/characters_detail_page.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/search_text_field.dart';
import 'package:rickandmorty/injection_container.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final charactersBloc = getIt<CharactersBloc>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Characters"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SearchTextField(
                  hintText: 'Search by character name',
                  onChanged: (value) {
                    charactersBloc.add(SearchCharacterByNameEvent(value));
                  }),
            ),
            Expanded(
              child: BlocBuilder<CharactersBloc, CharactersState>(
                bloc: charactersBloc..add(const FindCharactersEvent()),
                builder: (context, state) {
                  if (state is CharactersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CharactersError) {
                    return const Center(
                      child: Text("Error loading characters"),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Loaded ${state.model.characters.length} of ${state.model.totalElements} characters",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Expanded(
                          child: CharactersGrid(
                              characters: state.model.characters,
                              isLoadingMore: state is CharactersLoadingMore,
                              onEndOfList: (v) {
                                charactersBloc
                                    .add(const FindMoreCharactersEvent());
                              },
                              onTap: (Character character) {
                                Navigator.push(
                                  context,
                                  CharactersDetail.route(character),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
