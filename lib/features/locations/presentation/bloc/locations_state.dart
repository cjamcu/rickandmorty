part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {
  final Model model;

  const LocationsState(this.model);

  @override
  List<Object> get props => [model];
}

class LocationsInitial extends LocationsState {
  LocationsInitial()
      : super(Model(
          locations: [],
          currentPage: 1,
          totalElements: 0,
          totalPages: 1,
        ));
}

class LocationsLoading extends LocationsState {
  const LocationsLoading(Model model) : super(model);
}

class LocationsLoaded extends LocationsState {
  const LocationsLoaded(Model model) : super(model);
}

class LocationsError extends LocationsState {
  const LocationsError(Model model) : super(model);
}

class LocationsMoreLoading extends LocationsState {
  const LocationsMoreLoading(Model model) : super(model);
}

class Model {
  final List<Location> locations;
  final int currentPage;
  final int totalElements;
  final int totalPages;

  Model({
    required this.locations,
    required this.currentPage,
    required this.totalElements,
    required this.totalPages,
  });

  copyWith({
    List<Location>? locations,
    int? currentPage,
    int? totalElements,
    int? totalPages,
  }) {
    return Model(
      locations: locations ?? this.locations,
      currentPage: currentPage ?? this.currentPage,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
