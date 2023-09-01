import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/locations/data/models/locations_model.dart';

import 'package:rickandmorty/features/locations/domain/entities/locations_info.dart';
import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final Client client;

  LocationsRepositoryImpl(this.client);

  @override
  Future<LocationsInfo> findLocations(int page) async {
    final params = {
      'page': '$page',
    };

    final Uri uri = Uri.https('rickandmortyapi.com', '/api/location', params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    final locationsResponse = LocationsModel.fromJson(data);

    return LocationsInfo(
      locations: locationsResponse.locations,
      totalPages: locationsResponse.totalPages,
    );
  }
}
