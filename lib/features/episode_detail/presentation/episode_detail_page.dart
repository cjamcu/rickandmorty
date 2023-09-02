import 'package:flutter/material.dart';
import 'package:rickandmorty/features/episodes/domain/entities/episode.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/characters_by_ids_widget/widget.dart';

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
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(episode.name),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Air Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(episode.airDate),
                    ],
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
