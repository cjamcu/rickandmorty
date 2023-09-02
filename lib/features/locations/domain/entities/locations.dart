import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class Locations {
  final List<Location> locations;
  final int totalPages;
  final int totalElements;

  Locations({
    required this.locations,
    required this.totalPages,
    required this.totalElements,
  });
}
