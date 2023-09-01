part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {
  final Model model;

  const LocationsState(this.model);

  @override
  List<Object> get props => [model];
}

class LocationsInitial extends LocationsState {
  LocationsInitial() : super(Model(locations: [], currentPage: 1));
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

class Model {
  final List<Location> locations;
  final int currentPage;

  Model({required this.locations, required this.currentPage});

  copyWith({List<Location>? locations, int? currentPage}) {
    return Model(
      locations: locations ?? this.locations,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
