import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class ListViewInfinite extends StatefulWidget {
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ValueChanged onEndOfList;
  final bool isLoadingMore;
  final bool primary;
  final bool shrinkWrap;
  final IndexedWidgetBuilder? separatorBuilder;

  const ListViewInfinite({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onEndOfList,
    required this.isLoadingMore,
    this.primary = false,
    this.shrinkWrap = false,
    this.separatorBuilder,
  });

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
    return ListView.separated(
      primary: widget.primary,
      shrinkWrap: widget.shrinkWrap,
      itemCount: widget.itemCount + (widget.isLoadingMore ? 1 : 0),
      // Add 1 for the loading indicator
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        } else {
          // This is the loading indicator
          return const Padding(
            padding: EdgeInsets.only(
              bottom: 16,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.mediumSpringGreen,
              ),
            ),
          );
        }
      },
      controller: scrollController,
      separatorBuilder:
          widget.separatorBuilder ?? (context, index) => const SizedBox(),
    );
  }
}
