part of 'episodes_bloc.dart';

abstract class EpisodesState extends Equatable {
  final Model model;

  const EpisodesState(this.model);

  @override
  List<Object?> get props => [model];
}

class EpisodesInitial extends EpisodesState {
  const EpisodesInitial()
      : super(const Model(
            episodes: [], totalPages: 1, currentPage: 1, totalElements: 0));
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

class EpisodesMoreLoading extends EpisodesState {
  const EpisodesMoreLoading(Model model) : super(model);
}
class Model extends Equatable {
  final List<Episode> episodes;
  final int totalPages;
  final int totalElements;
  final int currentPage;

  const Model(
      {required this.episodes,
      required this.totalElements,
      required this.totalPages,
      required this.currentPage});

  @override
  List<Object?> get props => [episodes, totalPages, currentPage, totalElements];

  copyWith({
    List<Episode>? episodes,
    int? totalPages,
    int? currentPage,
    int? totalElements,
  }) {
    return Model(
      episodes: episodes ?? this.episodes,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
