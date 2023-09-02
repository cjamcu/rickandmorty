import 'package:flutter/material.dart';

class LabelledContentList extends StatelessWidget {
  final List<LabelledContent> elements;

  const LabelledContentList({
    Key? key,
    required this.elements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 20,
        alignment: elements.length > 2
            ? WrapAlignment.spaceBetween
            : WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: elements.map((element) {
          final String title = element.title;
          final dynamic content = element.content;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(content.toString()),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class LabelledContent {
  final String title;
  final String content;

  LabelledContent({
    required this.title,
    required this.content,
  });
}
