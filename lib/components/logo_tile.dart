import 'package:flutter/material.dart';

class LogoTile extends StatelessWidget {
  final String imagePath;

  const LogoTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: 10,
    );
  }
}
