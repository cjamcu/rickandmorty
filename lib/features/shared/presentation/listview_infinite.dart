import 'package:flutter/material.dart';

class ListViewInfinite extends StatefulWidget {
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ValueChanged onEndOfList;
  final bool isLoadingMore;

  const ListViewInfinite({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onEndOfList,
    required this.isLoadingMore,
  }) : super(key: key);

  @override
  State<ListViewInfinite> createState() => _ListViewInfiniteState();
}

class _ListViewInfiniteState extends State<ListViewInfinite> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.extentAfter <
          0.1 * scrollController.position.extentInside) {
        if (!widget.isLoadingMore) {
          widget.onEndOfList(null);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount + (widget.isLoadingMore ? 1 : 0),
      // Add 1 for the loading indicator
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        } else {
          // This is the loading indicator
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      controller: scrollController,
    );
  }
}
