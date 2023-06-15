import 'package:flutter/material.dart';

import '../widgets/LabelScreen.dart';
import 'Home_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.order});

  final Map order;

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
          LabelScreen(title: "Order"),
          Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID :' + order["id"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Title :' + order["title"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text(
                      'Content :' + order["content"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Text('create_at :' + order["create_at"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              )),
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
