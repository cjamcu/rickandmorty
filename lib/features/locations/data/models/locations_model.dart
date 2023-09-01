import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {required super.id,
      required super.name,
      required super.type,
      required super.dimension,
      required super.residentsIds});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    List<String> residents = List<String>.from(json['residents'] as List);

    final residentsIds =
        residents.map((e) => int.parse(e.split('/').last)).toList();

    return LocationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      dimension: json['dimension'] ?? '',
      residentsIds: residentsIds,
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
    final locations = results.map((e) {
      return LocationModel.fromJson(e);
    }).toList();

    return LocationsModel(
      locations: locations,
      totalPages: json['info']['pages'] ?? 0,
    );
  }
}
