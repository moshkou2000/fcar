import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String label;
  final String placeholder;
  final Color searchFieldBackground;
  const SearchField({
    required this.label,
    required this.placeholder,
    this.searchFieldBackground = Colors.white,
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with SingleTickerProviderStateMixin {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_isActive)
          Text(widget.label,
              style: Theme.of(context).appBarTheme.titleTextStyle),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: _isActive
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: widget.searchFieldBackground,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: widget.placeholder,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isActive = false;
                                  });
                                },
                                icon: const Icon(Icons.close))),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      icon: const Icon(Icons.search)),
            ),
          ),
        ),
      ],
    );
  }
}
