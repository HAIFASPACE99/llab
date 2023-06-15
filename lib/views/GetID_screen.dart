import 'dart:convert';


import 'package:flutter/material.dart';

import '../services/api/User/getByID.dart';
import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';
import 'Home_screen.dart';

class GetScreenID extends StatefulWidget {
  const GetScreenID({super.key});

  @override
  State<GetScreenID> createState() => _GetScreenIDState();
}

class _GetScreenIDState extends State<GetScreenID> {
  Map order = {};
  final TextEditingController idController = TextEditingController();
  bool validate = false;
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
          const LabelScreen(title: "Get Data"),
          SizedBox(
            height: 100,
          ),
          TextFieldCustom(
            controller: idController,
            hint: "search by id",
            label: "ID",
            icon: Icons.search,
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () async {
                    if (idController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("TextFeild Required")));
                    } else {
                      try {
                        if (int.parse(idController.text) is int) {
                          order = json.decode(
                              (await getByID(id: idController.text)).body);
                          print(order);
                          if ((order["data"] as List).isEmpty) {
                            order = {};
                          } else {
                            order = order["data"][0];
                          }

                          setState(() {});
                        }
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 4,
                            content: Text("plase enter correct number")));
                      }
                    }
                  },
                  child: Text("Get id"))),
          Container(
            color: Colors.grey,
            child: Row(
              //  crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Visibility(
                    visible: order.isNotEmpty,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID : ' + order["id"].toString(),
                              style: TextStyle(color: Colors.white)),
                          Text('Title : ' + order["title"].toString(),
                              style: TextStyle(color: Colors.white)),
                          Text('Content : ' + order["content"].toString(),
                              style: TextStyle(color: Colors.white)),
                          Text(
                            'Create_at: ' + order["create_at"].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
                showDialog(
                    context: context,
                    // barrierColor: Color.fromARGB(98, 20, 89, 249),
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()));
              },
              child: Text("back"),
            ),
          ),
        ]),
      ),
    );
  }
}
