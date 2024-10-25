import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rickandmorty/app/colors.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class SearchInput extends StatefulWidget {
  final String hintText;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final Function(String)? onChanged;
  final Duration debounceDuration;

  const SearchInput({
    super.key,
    required this.hintText,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: _onSearchChanged,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
            ),
        prefixIcon: const Icon(Icons.search, color: AppColors.grey),
        suffixIcon: controller.text.isNotEmpty
            ? GradientContainer(
                child: IconButton(
                  onPressed: () {
                    controller.clear();
                    widget.onChanged?.call('');
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.black800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      textInputAction: TextInputAction.search,
    );
  }
}