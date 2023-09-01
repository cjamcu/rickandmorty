import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/features/location_detail/presentation/widgets/residents_widgets.dart';
import 'package:rickandmorty/features/locations/domain/entities/location.dart';

class LocationDetailPage extends StatelessWidget {
  static route(Location location) {
    return CupertinoPageRoute(
      builder: (context) => LocationDetailPage(
        location: location,
      ),
    );
  }

  final Location location;

  const LocationDetailPage({Key? key, required this.location})
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          location.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(location.type),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dimension",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(location.dimension),
                  ],
                ),
              ],
            ),
            ResidentsWidget(characterIds: location.residentsIds),
          ],
        ),
      ),
    );
  }
}
