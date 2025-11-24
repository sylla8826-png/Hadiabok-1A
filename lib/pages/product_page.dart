import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';
import 'cart_page.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
          )
        ],
      ),
      body: ListView(
        children: [
          if (product.images.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(height: 300.0, enableInfiniteScroll: false),
              items: product.images.map((url) => Image.network(url, fit: BoxFit.cover, width: double.infinity)).toList(),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('${product.price.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 18, color: Colors.green)),
                const SizedBox(height: 16),
                Text(product.description),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text('Ajouter au panier'),
                        onPressed: () {
                          cart.add(product);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ajouté au panier')));
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        cart.add(product);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                      },
                      child: const Text('Acheter'),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}