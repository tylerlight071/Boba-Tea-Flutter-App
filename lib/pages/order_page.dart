import 'package:boba_tea_app/models/drink.dart';
import 'package:boba_tea_app/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  final Drink drink;
  const OrderPage({super.key, 
    required this.drink,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // customize sweetness
  double sweetValue = 0.5;
  void customizeSweet(double value) {
    setState(() {
      sweetValue = value;
    });
  }

  // customize ice
  double iceValue = 0.75;
  void customizeIce(double value) {
    setState(() {
      iceValue = value;
    });
  }

  // customize pearls
  double pearlValue = 0.25;
  void customizePearl(double value) {
    setState(() {
      pearlValue = value;
    });
  }

  //add to cart
  void addToCart() {
    // firstly add to cart
    Provider.of<BubbleTeaShop>(context, listen: false).addToCart(widget.drink);

    // direct user back to shop page
    Navigator.pop(context);

    // let user know drink has been added to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(
              "${widget.drink.name} added to cart!  ",
              style: const TextStyle(fontSize: 18),),
              const Icon(Icons.check, color: Colors.green,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          widget.drink.name,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.brown.shade300,
      body: Column(children: [
        // drink image
        Image.asset(widget.drink.imagePath),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // sweetener slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text("Sweet"),
                  ),
                  Expanded(
                    child: Slider(
                      value: sweetValue,
                      label: sweetValue.toString(),
                      divisions: 4,
                      onChanged: (value) => customizeSweet(value),
                    ),
                  ),
                ],
              ),

              // ice slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text("Ice"),
                  ),
                  Expanded(
                    child: Slider(
                      value: iceValue,
                      label: iceValue.toString(),
                      divisions: 4,
                      onChanged: (value) => customizeIce(value),
                    ),
                  ),
                ],
              ),
              //pearl slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text("Pearls"),
                  ),
                  Expanded(
                    child: Slider(
                      value: pearlValue,
                      label: pearlValue.toString(),
                      divisions: 4,
                      onChanged: (value) => customizePearl(value),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // add to cart button
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElevatedButton(
            onPressed: addToCart,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
