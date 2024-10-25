import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class SearchStateMessage extends StatelessWidget {
  final String? imagePath;
  final String message;

  const SearchStateMessage({
    super.key,
    this.imagePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imagePath != null) ...[
          Image.asset(imagePath!),
          const SizedBox(height: 16),
        ],
        Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
