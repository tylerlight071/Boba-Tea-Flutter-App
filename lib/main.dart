import 'package:boba_tea_app/models/shop.dart';
import 'package:boba_tea_app/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            home: const AuthPage(),
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
