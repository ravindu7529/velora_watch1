import 'package:flutter/material.dart';
import 'package:velora_watch/screens/product_list_screen.dart';
import 'package:velora_watch/screens/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProductListScreen(), // Master list of watches
    const FormScreen(), // Example: We'll place our form here
    Center(child: Text('Favorites Screen Placeholder')),
    Center(child: Text('Profile Screen Placeholder')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // There's no AppBar here so that each sub-screen can have its own if needed.
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Watches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
