// ignore_for_file: use_build_context_synchronously

import "package:boba_tea_app/components/drink_tile.dart";
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
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          // heading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Bubble Tea Shop",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // ! sign out button
              IconButton(
                  onPressed: signUserOut,
                  icon: const Icon(
                    Icons.logout, color: Colors.black45,
                  ))
            ],
          ),
          const Divider(),

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
      )),
    );
  }
}
