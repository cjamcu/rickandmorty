part of 'episodes_bloc.dart';

abstract class EpisodesState extends Equatable {
  final Model model;

  const EpisodesState(this.model);

  @override
  List<Object?> get props => [model];
}

class EpisodesInitial extends EpisodesState {
  const EpisodesInitial()
      : super(const Model(episodes: [], totalPages: 0, currentPage: 0));
}

class EpisodesLoading extends EpisodesState {
  const EpisodesLoading(Model model) : super(model);
}

class EpisodesLoaded extends EpisodesState {
  const EpisodesLoaded(Model model) : super(model);
}

class EpisodesError extends EpisodesState {
  const EpisodesError(Model model) : super(model);

  @override
  List<Object?> get props => [model];
}

class Model extends Equatable {
  final List<Episode> episodes;
  final int totalPages;
  final int currentPage;

  const Model(
      {required this.episodes,
      required this.totalPages,
      required this.currentPage});

  @override
  List<Object?> get props => [episodes, totalPages, currentPage];

  copyWith({
    List<Episode>? episodes,
    int? totalPages,
    int? currentPage,
  }) {
    return Model(
      episodes: episodes ?? this.episodes,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
