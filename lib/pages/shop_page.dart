// ignore_for_file: use_build_context_synchronously

import "package:boba_tea_app/components/drink_tile.dart";
import "package:boba_tea_app/components/logo_tile.dart";
import "package:boba_tea_app/models/drink.dart";
import "package:boba_tea_app/models/shop.dart";
import "package:boba_tea_app/pages/order_page.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //user selected a drink, go to order page
  void goToOrderPage(Drink drink) {
    //navigate to order page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderPage(
          drink: drink,
        ),
      ),
    );
  }

  //sign user out
  void signUserOut() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      barrierDismissible:
          false, // Prevents the dialog from being dismissed by tapping outside
    );

    try {
      await Future.delayed(const Duration(seconds: 1));
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Handle potential sign out errors here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while signing out.'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      // Dismiss the dialog whether sign out is successful or not
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleTeaShop>(
      builder: (context, value, child) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: const Color(0xFFB0A599),
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text(
              "Bangin' Boba",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
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
          body: Column(children: [
            const Divider(),
            // heading

            // list of drinks
            Expanded(
              child: ListView.builder(
                  itemCount: value.shop.length,
                  itemBuilder: (context, index) {
                    // get individual drink
                    Drink individualDrink = value.shop[index];

                    // return drink as a tile
                    return DrinkTile(
                      drink: individualDrink,
                      onTap: () => goToOrderPage(individualDrink),
                      trailing: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      )),
    );
  }
}
