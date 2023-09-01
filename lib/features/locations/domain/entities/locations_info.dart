import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class LocationsInfo {
  final List<Location> locations;
  final int totalPages;

  LocationsInfo({required this.locations, required this.totalPages});
}
