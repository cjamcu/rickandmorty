import 'package:rickandmorty/features/locations/domain/entities/locations_info.dart';

abstract class LocationsRepository {
  Future<LocationsInfo> findLocations(int page);
}
