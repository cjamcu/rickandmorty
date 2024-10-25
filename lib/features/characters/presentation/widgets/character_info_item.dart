import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class CharacterInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const CharacterInfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.white,
              ),
        ),
      ],
    );
  }
}
