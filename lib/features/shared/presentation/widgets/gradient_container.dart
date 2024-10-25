import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  const GradientContainer({
    super.key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [AppColors.mediumSpringGreen, AppColors.blue500],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: child,
    );
  }
}
