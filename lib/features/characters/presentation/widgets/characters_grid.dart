import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:rickandmorty/features/characters/domain/entities/character.dart';
import 'package:rickandmorty/features/characters/presentation/widgets/character_card.dart';

class CharactersGrid extends StatefulWidget {
  const CharactersGrid({
    Key? key,
    required this.characters,
    required this.onTap,
    this.onEndOfList,
    this.isLoadingMore = false,

  }) : super(key: key);

  final List<Character> characters;
  final ValueChanged<Character> onTap;
  final ValueChanged? onEndOfList;
  final bool isLoadingMore;

  @override
  State<CharactersGrid> createState() => _CharactersGridState();
}

class _CharactersGridState extends State<CharactersGrid> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.onEndOfList != null) {
      scrollController.addListener(() {
        if (scrollController.position.extentAfter <
            0.1 * scrollController.position.extentInside) {
          if (!widget.isLoadingMore) {
            widget.onEndOfList!(null);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      controller: scrollController,
      desiredItemWidth: 150,
      children: [
        ...widget.characters.map(
          (character) => CharacterCard(
            character: character,
            onTap: () => widget.onTap(character),
          ),
        ),
        if (widget.isLoadingMore)
          ...List.generate(
            2,
            (index) => const Center(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            )),
          ),
      ],
    );
  }
}
