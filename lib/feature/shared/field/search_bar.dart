import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({required this.onChanged, super.key});

  final Function(String) onChanged;

  @override
  ConsumerState<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        controller: _textEditingController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              kIsWeb ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: 'Search for a product',
          suffixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          suffixIcon: IconButton(
            constraints: const BoxConstraints(
              minHeight: 36,
              minWidth: 36,
            ),
            splashRadius: 24,
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              _textEditingController.clear();
              widget.onChanged(_textEditingController.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}
