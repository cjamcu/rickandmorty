import 'package:flutter/material.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/characters_by_ids_widget/widget.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/labelled_content_list.dart';

class EpisodeDetailPage extends StatelessWidget {
  static route({required Episode episode}) => MaterialPageRoute(
        builder: (context) => EpisodeDetailPage(episode: episode),
      );

  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(episode.episode),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LabelledContentList(
                elements: [
                  LabelledContent(
                    title: 'Name',
                    content: episode.name,
                  ),
                  LabelledContent(
                    title: 'Air Date',
                    content: episode.airDate,
                  ),
                ],
              ),
              const Divider(),
              CharactersByIds(
                  characterIds: episode.charactersIds, title: "Characters"),
            ],
          ),
        ));
  }
}
