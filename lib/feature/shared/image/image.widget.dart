import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.url,
    Key? key,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .95,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          url,
          loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
              ? child
              : const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error, stackTrace) => const Center(
              child: CircularProgressIndicator(
            color: Colors.deepOrange,
          )),
          color: Colors.grey,
          colorBlendMode: BlendMode.multiply,
        ),
      ),
    );
  }
}
