import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'product_page.dart';
import '../widgets/ad_banner.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({super.key});

  // Exemple statique — remplace par un stream Firestore
  List<Product> get demoProducts => List.generate(8, (i) {
        return Product(
          id: 'p$i',
          title: 'Produit ${i + 1}',
          description: 'Description du produit ${i + 1}',
          price: 9.99 + i,
          images: ['https://placeimg.com/640/480/tech/${i + 1}'],
          sellerId: 'seller-$i',
        );
      });

  @override
  Widget build(BuildContext context) {
    final products = demoProducts;
    return Scaffold(
      appBar: AppBar(title: const Text('Boutique')), 
      body: Column(
        children: [
          const AdBanner(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductPage(product: p))),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(aspectRatio: 1.6, child: Image.network(p.images.isNotEmpty ? p.images.first : '', fit: BoxFit.cover)),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('${p.price.toStringAsFixed(2)} €', style: const TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}