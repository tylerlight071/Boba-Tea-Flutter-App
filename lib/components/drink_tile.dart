import "package:boba_tea_app/models/drink.dart";
import "package:flutter/material.dart";

class DrinkTile extends StatelessWidget {
  final Drink drink;
  final Widget? trailing;
  final Function()? onTap;
  const DrinkTile(
      {super.key,
      required this.drink,
      required this.onTap,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Container(
          height: 120, // Set the height of the container
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.brown[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(drink.imagePath),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drink.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      drink.price,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
