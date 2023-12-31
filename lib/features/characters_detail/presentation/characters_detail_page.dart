import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_cache_image.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/labelled_content_list.dart'
    show LabelledContent, LabelledContentList;

class CharactersDetail extends StatelessWidget {
  static route(Character character) {
    return CupertinoPageRoute(
      builder: (context) => CharactersDetail(
        character: character,
      ),
    );
  }

  final Character character;

  const CharactersDetail({Key? key, required this.character}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: [
                  CharacterCacheImage(
                    imageUrl: character.image,
                    heroTag: character.id,
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  LabelledContentList(
                    elements: [
                      LabelledContent(
                          title: 'Status', content: character.status),
                      LabelledContent(
                        title: 'Species',
                        content: character.species,
                      ),
                      LabelledContent(
                        title: 'Gender',
                        content: character.gender,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
