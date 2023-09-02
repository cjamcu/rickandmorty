import 'dart:convert';

import 'package:http/http.dart';
import 'package:rickandmorty/features/locations/data/models/locations_model.dart';
import 'package:rickandmorty/features/locations/domain/entities/location.dart';

import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';
import 'package:rickandmorty/features/shared/data/models/get_all_api_model.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  final Client client;

  LocationsRepositoryImpl(this.client);

  @override
  Future<GetAllApiResponse<Location>> findLocations(int page) async {
    final params = {
      'page': '$page',
    };

    final Uri uri = Uri.https('rickandmortyapi.com', '/api/location', params);

    final response = await client.get(uri);
    final data = json.decode(response.body);

    return GetAllApiModelModel<LocationModel>.fromJson(
      data,
      (itemJson) => LocationModel.fromJson(itemJson),
    );
  }
}
