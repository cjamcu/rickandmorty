import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/locations/domain/entities/location.dart';
import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';
import 'package:rickandmorty/features/shared/domain/entities/get_all_api_response.dart';

class FindLocations
    implements UseCase<GetAllApiResponse<Location>, FindLocationsParams> {
  final LocationsRepository repository;

  FindLocations(this.repository);

  @override
  Future<GetAllApiResponse<Location>> execute(
      FindLocationsParams params) async {
    return await repository.findLocations(params.page);
  }
}

class FindLocationsParams {
  final int page;

  FindLocationsParams(this.page);
}
