import 'package:rickandmorty/core/usecases/usecase.dart';
import 'package:rickandmorty/features/locations/domain/entities/locations_info.dart';
import 'package:rickandmorty/features/locations/domain/repositories/locations_repository.dart';

class FindLocations implements UseCase<LocationsInfo, FindLocationsParams> {
  final LocationsRepository repository;

  FindLocations(this.repository);

  @override
  Future<LocationsInfo> execute(FindLocationsParams params) async {
    return await repository.findLocations(params.page);
  }
}

class FindLocationsParams {
  final int page;

  FindLocationsParams(this.page);
}
