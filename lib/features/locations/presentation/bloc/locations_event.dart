part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();
}


class FindLocationsEvent extends LocationsEvent {
  @override
  List<Object> get props => [];
}

