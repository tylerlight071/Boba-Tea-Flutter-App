import 'package:boba_tea_app/models/shop.dart';
import 'package:boba_tea_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BubbleTeaShop(),
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const LoginPage(),
            theme: ThemeData(
              primaryColor: Colors.brown,
              sliderTheme: SliderThemeData(
                  thumbColor: Colors.brown[100],
                  activeTrackColor: Colors.brown,
                  inactiveTrackColor: Colors.brown.withOpacity(0.5),
                  valueIndicatorColor: Colors.brown),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            )));
  }
}
