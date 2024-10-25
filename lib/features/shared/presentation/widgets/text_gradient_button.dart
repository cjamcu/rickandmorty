import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/gradient_container.dart';

class TextGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;

  const TextGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black600,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: GradientContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                icon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
