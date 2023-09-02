import 'package:rickandmorty/features/locations/domain/entities/locations.dart';

abstract class LocationsRepository {
  Future<Locations> findLocations(int page);
}
