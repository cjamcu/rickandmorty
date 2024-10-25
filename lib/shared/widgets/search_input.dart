import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

class SearchInput extends StatefulWidget {
  final String hintText;
  final VoidCallback? onTap;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  const SearchInput({
    super.key,
    required this.hintText,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
            ),
        prefixIcon: const Icon(Icons.search, color: AppColors.grey),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close, color: AppColors.grey),
                onPressed: () {
                  setState(() {
                    _controller.clear();
                  });
                  widget.onChanged?.call('');
                },
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
      onChanged: (value) {
        setState(() {}); // Esto forzará una reconstrucción para mostrar/ocultar el icono X
        widget.onChanged?.call(value);
      },
    );
  }
}
