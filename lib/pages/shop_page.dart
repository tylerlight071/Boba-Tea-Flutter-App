import "package:boba_tea_app/components/drink_tile.dart";
import "package:boba_tea_app/models/drink.dart";
import "package:boba_tea_app/models/shop.dart";
import "package:boba_tea_app/pages/order_page.dart";
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

  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleTeaShop>(
      builder: (context, value, child) => SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          // heading
          const Text(
            "Bubble Tea Shop",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
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
                      child: Icon(Icons.arrow_forward_ios,),
                    ),
                  );
                }),
          )
        ]),
      )),
    );
  }
}
