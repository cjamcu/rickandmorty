
import 'package:rickandmorty/features/locations/domain/entities/location.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

abstract class LocationsRepository {
  Future<GetAllApiResponse<Location>> findLocations(int page);
}
