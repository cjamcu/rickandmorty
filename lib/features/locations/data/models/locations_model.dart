import 'package:rickandmorty/features/locations/domain/entities/location.dart';
import 'package:rickandmorty/features/locations/domain/entities/locations.dart';

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

class LocationsModel extends Locations {
  final List<LocationModel> results;
  final int pages;
  final int count;

  LocationsModel({
    required this.results,
    required this.pages,
    required this.count,
  }) : super(
          totalElements: count,
          totalPages: pages,
          locations: results,
        );

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((character) => LocationModel.fromJson(character))
        .toList();

    return LocationsModel(
      results: results,
      pages: json['info']['pages'],
      count: json['info']['count'],
    );
  }
}
