import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/episode_detail/presentation/episode_detail_page.dart';
import 'package:rickandmorty/features/episodes/presentation/bloc/episodes_bloc.dart';
import 'package:rickandmorty/features/shared/presentation/listview_infinite.dart';
import 'package:rickandmorty/injection_container.dart';

final episodesBloc = getIt<EpisodesBloc>();

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: BlocBuilder<EpisodesBloc, EpisodesState>(
        bloc: episodesBloc..add(const FindEpisodesEvent()),
        builder: (context, state) {
          if (state is EpisodesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is EpisodesError) {
            return const Center(
              child: Text('Error loading episodes'),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                child: Text(
                  "Loaded ${state.model.episodes.length} of ${state.model.totalElements} episodes",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListViewInfinite(
                  itemCount: state.model.episodes.length,
                  itemBuilder: (context, index) {
                    final episode = state.model.episodes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          EpisodeDetailPage.route(episode: episode),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.tv,
                            size: 25,
                          ),
                          title: Text(episode.episode,
                              style: const TextStyle(fontSize: 20),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(episode.name),
                              RichText(
                                text: TextSpan(
                                  text: 'Aired on ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: episode.airDate,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onEndOfList: (value) {
                    episodesBloc.add(const FindMoreEpisodesEvent());
                  },
                  isLoadingMore: state is EpisodesMoreLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
