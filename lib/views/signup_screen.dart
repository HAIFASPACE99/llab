
import 'package:flutter/material.dart';

import '../services/api/Auth/createUser.dart';
import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';
import 'Login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

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

      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                const LabelScreen(title: "Sign up"),
                SizedBox(
                  height: 200,
                ),
                TextFieldCustom(
                  hint: "user123",
                  label: "User name",
                  icon: Icons.person,
                  onChanged: (value) {
                    print(value);
                    username = value;
                  },
                ),
                TextFieldCustom(
                  hint: "Fahad Alazmi",
                  label: "Name",
                  icon: Icons.person,
                  controller: nameController,
                ),
                TextFieldCustom(
                  hint: "example@gmail.com",
                  label: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                TextFieldCustom(
                  hint: "AAaa1100229933",
                  label: "password",
                  icon: Icons.password_outlined,
                  obscureText: true,
                  isPassword: true,
                  onChanged: (pass) {
                    password = pass;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () async {
                        final Map body = {
                          "email": emailController.text,
                          "password": password,
                          "username": username,
                          "name": nameController.text
                        };
                        final response = await createUser(body: body);
                        print(response.body);

                        if (response.statusCode == 400) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("TextFeild Required ")));
                        } else if (response.statusCode == 200) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        }
                      },
                      child: Text("Create"),
                    )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () async {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        },
                        child: Text("log in")))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
