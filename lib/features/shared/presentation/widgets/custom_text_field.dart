import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            gradient: _isFocused
                ? const LinearGradient(
                    colors: [AppColors.mediumSpringGreen, AppColors.blue500],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                if (widget.hintText != null && widget.controller.text.isEmpty)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          widget.hintText!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [AppColors.mediumSpringGreen, AppColors.blue500],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: TextField(
                    focusNode: _focusNode,
                    cursorColor: Colors.white,
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
