import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;
  const AdBanner({super.key, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(8),
          image: imageUrl != null ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover) : null,
        ),
        child: imageUrl == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.local_offer_outlined, color: Colors.black54),
                  SizedBox(width: 8),
                  Text('Espace publicitaire', style: TextStyle(color: Colors.black54)),
                ],
              )
            : null,
      ),
    );
  }
}