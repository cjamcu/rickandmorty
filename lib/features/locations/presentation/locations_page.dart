import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/location_detail/presentation/location_detail_page.dart';
import 'package:rickandmorty/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:rickandmorty/features/shared/presentation/listview_infinite.dart';
import 'package:rickandmorty/injection_container.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({Key? key}) : super(key: key);

  final locationsBloc = getIt<LocationsBloc>()..add(FindLocationsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        centerTitle: true,
      ),
      body: BlocBuilder<LocationsBloc, LocationsState>(
        bloc: locationsBloc..add(FindLocationsEvent()),
        builder: (context, state) {
          if (state is LocationsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LocationsError) {
            return const Center(
              child: Text('Error loading locations'),
            );
          }

          final locations = state.model.locations;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                child: Text(
                  "Loaded ${state.model.locations.length} of ${state.model.totalElements} locations",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListViewInfinite(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          size: 25,
                        ),
                        title: Text(
                          location.name,
                          style: const TextStyle(fontSize: 20),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(location.type),
                        onTap: () {
                          Navigator.push(
                            context,
                            LocationDetailPage.route(location),
                          );
                        },
                      ),
                    );
                  },
                  onEndOfList: (v) {
                    locationsBloc.add(FindMoreLocationsEvent());
                  },
                  isLoadingMore: state is LocationsMoreLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
