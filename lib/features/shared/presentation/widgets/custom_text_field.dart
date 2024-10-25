import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          validator: validator,
          cursorColor: AppColors.mediumSpringGreen,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.grey,
            ),
            filled: true,
            fillColor: AppColors.black600,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.mediumSpringGreen),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.red400),
            ),
            errorStyle: const TextStyle(color: AppColors.red400),
          ),
        ),
      ],
    );
  }
}
