import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplaynameWidget extends ConsumerWidget {
  final String? displayname;
  final double width;
  const DisplaynameWidget({
    required this.width,
    this.displayname,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 3,
      left: 10,
      width: width - 10,
      child: _buildDisplayname(context),
    );
  }

  Widget _buildDisplayname(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: 24,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Colors.black87,
          ),
        ],
      ),
      child: Center(
        child: Text(
          displayname ?? '',
          maxLines: 1,
          overflow: TextOverflow.clip,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
