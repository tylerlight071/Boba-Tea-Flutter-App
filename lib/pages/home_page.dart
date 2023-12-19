import 'package:boba_tea_app/components/bottom_nav_bar.dart';
import 'package:boba_tea_app/components/logo_tile.dart';
import 'package:boba_tea_app/pages/cart_page.dart';
import 'package:boba_tea_app/pages/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

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
      backgroundColor: const Color(0xFFB0A599),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: navigateBottomBar,
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
            child: Container(
              color: const Color(0xFFCEC5BA),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: const [
                        DrawerHeader(
                            child: LogoTile(
                          imagePath: 'lib/assets/images/pearl_milk_tea.png',
                        )),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: // ! go to profile page
                                null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: ListTile(
                            leading: Icon(Icons.info),
                            title: Text(
                              "About",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // ! go to about page
                            onTap: null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(
                              "Settings",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // ! go to settings page
                            onTap: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.black54,
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => signUserOut(),
                  )
                ],
              ),
            ),
          ),
    );
  }
  
  signUserOut() {}
}
