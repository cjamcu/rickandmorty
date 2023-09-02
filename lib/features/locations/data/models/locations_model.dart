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
