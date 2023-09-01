import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/locations/domain/entities/location.dart';
import 'package:rickandmorty/features/locations/domain/usecase/find_locations.dart';

part 'locations_event.dart';

part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final FindLocations findLocations;

  LocationsBloc(this.findLocations) : super(LocationsInitial()) {
    on<FindLocationsEvent>(_findLocationsEvent);
  }

  Future<FutureOr<void>> _findLocationsEvent(
      FindLocationsEvent event, Emitter<LocationsState> emit) async {
    emit(LocationsLoading(state.model));
    try {
      final locationsInfo = await findLocations.execute(FindLocationsParams(
        state.model.currentPage,
      ));
      emit(LocationsLoaded(state.model.copyWith(
        locations: locationsInfo.locations,
        currentPage: state.model.currentPage + 1,
      )));
    } catch (e) {
      emit(LocationsError(state.model));
    }
  }
}
