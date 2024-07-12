import 'package:flutter/material.dart';
import 'package:timbu/screens/mainscreen/pages/checkout_screen.dart';
import 'package:timbu/screens/products_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const ProductsScreen(),
    const CheckoutScreen(),
  ];

  // function to update the selected index to enable page changes
  void _updateSelectedBottomNavIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 55,
        // backgroundColor: ColorConstants.whiteColor,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _updateSelectedBottomNavIndex(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Products",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: "Checkout",
          )
        ],
      ),
    );
  }
}
