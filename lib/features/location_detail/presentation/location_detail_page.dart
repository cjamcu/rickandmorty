import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rickandmorty/features/locations/domain/entities/location.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/characters_by_ids_widget/widget.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/labelled_content_list.dart';

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
            LabelledContentList(
              elements: [
                LabelledContent(
                  title: 'Type',
                  content: location.type,
                ),
                LabelledContent(
                  title: 'Dimension',
                  content: location.dimension,
                ),
              ],
            ),
            const Divider(),
            CharactersByIds(
                title: "Residents", characterIds: location.residentsIds),
          ],
        ),
      ),
    );
  }
}
