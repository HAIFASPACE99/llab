
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Home_screen.dart';
import 'Login_screen.dart';

class LodgingPage extends StatefulWidget {
  const LodgingPage({super.key});

  @override
  State<LodgingPage> createState() => _LodgingPageState();
}

class _LodgingPageState extends State<LodgingPage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return box.hasData("token") ? const HomeScreen() : LoginScreen();
  }
}
