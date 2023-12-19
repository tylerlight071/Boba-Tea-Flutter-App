import 'package:boba_tea_app/models/drink.dart';
import 'package:boba_tea_app/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  final Drink drink;
  const OrderPage({
    super.key,
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
      widget.drink.sweetValue = value;
    });
  }

  // customize ice
  double iceValue = 0.75;
  void customizeIce(double value) {
    setState(() {
      iceValue = value;
      widget.drink.iceValue = value;
    });
  }

  // customize pearls
  double pearlValue = 0.25;
  void customizePearl(double value) {
    setState(() {
      pearlValue = value;
      widget.drink.pearlValue = value;
    });
  }

  //add to cart
  void addToCart() {
    // firstly add to cart
    Provider.of<BubbleTeaShop>(context, listen: false)
        .addToCartWithCustomizations(
            widget.drink, sweetValue, iceValue, pearlValue);

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
              style: const TextStyle(fontSize: 18),
            ),
            const Icon(
              Icons.check,
              color: Colors.green,
            )
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
        backgroundColor: const Color(0xFFB0A599),
      ),
      backgroundColor: const Color(0xFFB0A599),
      body: Column(children: [
        const Divider(),
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
                    child: Theme(
                      data: ThemeData(
                        sliderTheme: SliderThemeData(
                          activeTrackColor: Colors.pink.shade200,
                          inactiveTrackColor: Colors.pink.shade100,
                          thumbColor: Colors.pink.shade400,
                          valueIndicatorColor: Colors.pink.shade400,
                          trackHeight: 3,
                        ),
                      ),
                      child: Slider(
                        value: sweetValue,
                        label: widget.drink.getSweetLabel(),
                        divisions: 4,
                        onChanged: (value) => customizeSweet(value),
                      ),
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
                    child: Theme(
                      data: ThemeData(
                        sliderTheme: SliderThemeData(
                          activeTrackColor: Colors.blue.shade200,
                          inactiveTrackColor: Colors.blue.shade100,
                          thumbColor: Colors.blue.shade400,
                          valueIndicatorColor: Colors.blue.shade400,
                          trackHeight: 3,
                        ),
                      ),
                      child: Slider(
                        value: iceValue,
                        label: widget.drink.getIceLabel(),
                        divisions: 4,
                        onChanged: (value) => customizeIce(value),
                      ),
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
                    child: Theme(
                      data: ThemeData(
                        sliderTheme: const SliderThemeData(
                          activeTrackColor: Colors.black54,
                          inactiveTrackColor: Colors.black45,
                          thumbColor: Colors.black,
                          valueIndicatorColor: Colors.black87,
                          trackHeight: 3,
                        ),
                      ),
                      child: Slider(
                        value: pearlValue,
                        label: widget.drink.getPearlLabel(),
                        divisions: 4,
                        onChanged: (value) => customizePearl(value),
                      ),
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
