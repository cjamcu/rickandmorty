import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {required super.id,
      required super.name,
      required super.type,
      required super.dimension});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      dimension: json['dimension'] ?? '',
    );
  }
}

class LocationsModel {
  final List<LocationModel> locations;
  final int totalPages;

  LocationsModel({
    required this.locations,
    required this.totalPages,
  });

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List;
    final locations = results.map((e) => LocationModel.fromJson(e)).toList();

    return LocationsModel(
      locations: locations,
      totalPages: json['info']['pages'] ?? 0,
    );
  }
}
