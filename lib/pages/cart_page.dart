// ignore_for_file: use_build_context_synchronously

import 'package:boba_tea_app/components/drink_tile_cart.dart';
import 'package:boba_tea_app/models/drink.dart';
import 'package:boba_tea_app/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  // remove drink from cart
  void removeDrinkFromCart(Drink drink) {
    // remove drink from cart
    Provider.of<BubbleTeaShop>(context, listen: false)
        .removeDrinkFromCart(drink);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleTeaShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            // heading
            children: [
              const Icon(Icons.shopping_cart, size: 50, color: Colors.black54,),
              const Text(
                "Your Cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Divider(),

// Inside your ListView.builder
              Expanded(
                child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                    //get individual drink in cart first
                    Drink drink = value.cart[index];

                    // return drink as a tile
                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(10),
                            onPressed: (context) =>
                                value.removeDrinkFromCart(drink),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: DrinkTileCart(
                        drink: drink,
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              // total price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value.totalPrice,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              //checkout button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 18.0,
                                  bottom: 18.0,
                                  left: 2.0,
                                  right: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircularProgressIndicator(),
                                  Text(
                                    "Processing Payment...",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      await Future.delayed(const Duration(seconds: 2));

                      Navigator.pop(context);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Payment: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              content: const Row(
                                children: [
                                  Text(
                                    "Payment Successful!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                  Icon(Icons.check, color: Colors.green)
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Provider.of<BubbleTeaShop>(context,
                                            listen: false)
                                        .clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          });
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Pay",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
