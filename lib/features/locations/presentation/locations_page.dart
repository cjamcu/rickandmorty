import 'package:flutter/material.dart';
import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({Key? key}) : super(key: key);

  final List<Location> locations = [
    const Location(
        id: 1,
        name: 'Earth (C-137)',
        type: 'Planet',
        dimension: 'Dimension C-137'),
    const Location(
        id: 2, name: 'Abadango', type: 'Cluster', dimension: 'unknown'),
    const Location(
        id: 3,
        name: 'Citadel of Ricks',
        type: 'Space station',
        dimension: 'unknown'),
    const Location(
        id: 4,
        name: 'Worldender\'s lair',
        type: 'Planet',
        dimension: 'unknown'),
    const Location(
        id: 5,
        name: 'Anatomy Park',
        type: 'Microverse',
        dimension: 'Dimension C-137'),
    const Location(
        id: 4,
        name: 'Worldender\'s lair',
        type: 'Planet',
        dimension: 'unknown'),
    const Location(
        id: 5,
        name: 'Anatomy Park',
        type: 'Microverse',
        dimension: 'Dimension C-137'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        centerTitle: true,
      ),
      body: ListView.builder(
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
              title: Text(location.name),
              subtitle: Text(location.type),
              trailing: Text(location.dimension),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
