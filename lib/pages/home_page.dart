import 'package:boba_tea_app/components/bottom_nav_bar.dart';
import 'package:boba_tea_app/pages/cart_page.dart';
import 'package:boba_tea_app/pages/shop_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//navigate bottom bar
  int _selectedIndex = 0;

  void navigateBottomBar(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //shop page
    const ShopPage(),

    // cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade400,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: navigateBottomBar,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
