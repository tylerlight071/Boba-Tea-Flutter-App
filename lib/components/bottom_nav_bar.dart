import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";

class MyBottomNavBar extends StatelessWidget {
  final Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.white,
        color: Colors.black45,
        tabActiveBorder: Border.all(color: Colors.white),
        gap: 8,
        tabs: const [
          //shop
          GButton(icon: Icons.home, text: "Shop"),
          //cart
          GButton(icon: Icons.shopping_bag, text: "Cart"),
        ],
      ),
    );
  }
}
