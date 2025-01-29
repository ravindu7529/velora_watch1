import 'package:flutter/material.dart';
import 'package:velora_watch/screens/product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  // A sample list of watch items (title, price, image, description, etc.)
  final List<Map<String, String>> watchItems = const [
    {
      'name': 'Velora Classic',
      'price': '\$199',
      'image': 'assets/images/watch1.png',
      'description': 'A timeless design with a modern twist.'
    },
    {
      'name': 'Velora Sport',
      'price': '\$249',
      'image': 'assets/images/watch2.png',
      'description': 'Built for performance and durability.'
    },
    {
      'name': 'Velora Luxe',
      'price': '\$499',
      'image': 'assets/images/watch3.png',
      'description': 'Elegant, premium materials for special occasions.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Velora Watches'),
      ),
      body: ListView.builder(
        itemCount: watchItems.length,
        itemBuilder: (context, index) {
          final item = watchItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 3.0,
            child: ListTile(
              leading: Image.asset(
                item['image']!,
                width: 50,
                height: 50,
              ),
              title: Text(
                item['name']!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(item['price']!),
              onTap: () {
                // Navigate to detail screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      name: item['name']!,
                      price: item['price']!,
                      image: item['image']!,
                      description: item['description']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
