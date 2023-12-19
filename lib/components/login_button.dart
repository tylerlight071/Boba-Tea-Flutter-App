import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function signUserIn;
  final String text;
  const LoginButton({super.key, required this.signUserIn, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              signUserIn();
            },
            
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ));
  }
}