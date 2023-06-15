import 'package:flutter/material.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title,
      style: TextStyle(color: Colors.white,
          fontFamily: "TiltPrism", fontWeight: FontWeight.w900, fontSize: 30),
    ));
  }
}