import 'dart:convert';


import 'package:app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../services/api/Auth/login.dart';
import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';
import 'Home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // BoxDecoration takes the image
        decoration: BoxDecoration(
          // Image set to background of the body
          image: DecorationImage(
              image: AssetImage("assets/images/b.jpg"), fit: BoxFit.cover),
        ),

        child: ListView(children: [
          SizedBox(
            height: 50,
          ),
          LabelScreen(
            title: "Log In",
          ),
          SizedBox(
            height: 200,
          ),
          TextFieldCustom(
            hint: "example@gmail.com",
            label: "Email",
            icon: Icons.email,
            controller: emailController,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldCustom(
            hint: "******",
            label: "Password",
            icon: Icons.password,
            isPassword: true,
            controller: passwordController,
          ),
          SizedBox(
            height: 100,
          ),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () async {
                    final Map body = {
                      "email": emailController.text,
                      "password": passwordController.text,
                    };
                    final response = await loginUser(body: body);
                    if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("TextFeild Required")));
                    }

                    if (response.statusCode == 400) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("enter corect data ")));
                    } else if (response.statusCode == 200) {
                      final box = GetStorage();
                      box.write(
                          "token", json.decode(response.body)["data"]["token"]);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    }
                  },
                  child: Text("Log in"))),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                        (route) => false);
                  },
                  child: Text("Sing Up in")))
        ]),
      ),
    );
  }
}
