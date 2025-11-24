import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/product_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cart = CartService.instance;

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final items = cart.items;
    final total = items.fold<double>(0, (s, p) => s + p.price);
    return Scaffold(
      appBar: AppBar(title: const Text('Panier')), 
      body: items.isEmpty
          ? const Center(child: Text('Panier vide'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final Product p = items[i];
                      return ListTile(
                        leading: p.images.isNotEmpty ? Image.network(p.images.first, width: 56, fit: BoxFit.cover) : const Icon(Icons.shopping_bag),
                        title: Text(p.title),
                        subtitle: Text('${p.price.toStringAsFixed(2)} €'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => cart.remove(p),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text('Total: ${total.toStringAsFixed(2)} €', style: const TextStyle(fontSize: 18)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: intégrer paiement / commande
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Commande simulée')));
                          cart.clear();
                        },
                        child: const Text('Commander'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}