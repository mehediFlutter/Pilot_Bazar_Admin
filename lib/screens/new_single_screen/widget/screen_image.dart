import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScreenImage extends StatelessWidget {
  final String imageUrl;
  final String code;
  const ScreenImage({
    super.key,
    required this.imageUrl,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(), // Placeholder widget while loading
              errorWidget: (context, url, error) => Image.network(
                "https://placehold.co/600x400?font=Roboto&text=no+image+found",
                fit: BoxFit.cover, // Fallback image if not found
              ),
              fit: BoxFit.cover, // Adjust the image fit as needed
            ),
            Positioned(
                top: 175,
                left: 295,
                child: Container(
                    height: 18,
                    width: 56,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        code,
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
