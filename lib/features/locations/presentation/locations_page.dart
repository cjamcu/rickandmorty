
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:rickandmorty/injection_container.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: getIt<LocationsBloc>()..add(FindLocationsEvent()),
        child: BlocBuilder<LocationsBloc, LocationsState>(
          bloc: getIt<LocationsBloc>()..add(FindLocationsEvent()),
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

            return ListView.builder(
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
                    trailing: Text(location.dimension),
                    onTap: () {},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
