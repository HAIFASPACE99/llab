import 'dart:convert';


import 'package:app_api/services/extan/navigitor/pushEXT.dart';
import 'package:app_api/views/GetID_screen.dart';
import 'package:app_api/views/Login_screen.dart';
import 'package:app_api/views/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../services/api/User/create_order.dart';
import '../services/api/User/get_orders.dart';
import '../widgets/CardOrders.dart';
import '../widgets/LabelScreen.dart';
import '../widgets/TextFieldCustom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List listOrders = [];
  @override
  void initState() {
    super.initState();
    _getDataOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pushAndRemove(view: GetScreenID());
              },
              icon: Icon(Icons.search))
        ],
        leading: IconButton(
            onPressed: () {
              context.pushAndRemove(view: LoginScreen());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: DecoratedBox(
        // BoxDecoration takes the image
        decoration: BoxDecoration(
          // Image set to background of the body
          image: DecorationImage(
              image: AssetImage("assets/images/b.jpg"), fit: BoxFit.cover),
        ),

        child: ListView(
          children: [
            TextFieldCustom(
              hint: "Title",
              label: "Title",
              controller: titleController,
              icon: Icons.read_more,
            ),
            TextFieldCustom(
                minLines: 3,
                maxLines: 10,
                hint: "content",
                label: "content",
                controller: contentController,
                icon: Icons.content_copy),

            SizedBox(
              height: 30,
            ),

            Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text("GetData"),
              onPressed: () async {
                if (contentController.text.isEmpty ||
                    titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("TextFeild Required")));
                } else {
                  try {
                    if (contentController.text.isNotEmpty &&
                        titleController.text.isNotEmpty) {
                      final result = await createOrder(context: context, body: {
                        "title": titleController.text,
                        "content": contentController.text,
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("adding done")));
                      print(result.statusCode);
                      showDialog(
                          context: context,
                          // barrierColor: Color.fromARGB(98, 20, 89, 249),
                          builder: (context) =>
                              Center(child: CircularProgressIndicator()));
                      _getDataOrders();
                    }
                  } catch (error) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     elevation: 4,
                    //     content: Text("plase enter correct number")));
                  }
                }
              },
            )),
            SizedBox(
              height: 50,
            ),

            //-------------- display orders ---------------
//listOrders.isEmpty? CircularProgressIndicator() :
            for (var item in listOrders.reversed)
              InkWell(
                  onTap: () {
                    context.pushAndRemove(view: OrderScreen(order: item));
                  },
                  child: CardOrders(order: item)),
          ],
        ),
      ),
    );
  }

  _getDataOrders() async {
    if ((await getOrders()).statusCode == 200) {
      listOrders = json.decode((await getOrders()).body)["data"];
      print(listOrders);
      setState(() {});
    } else {
      final box = GetStorage();
      box.remove("token");
      context.pushAndRemove(view: LoginScreen());
    }
  }
}

lodingPage({required BuildContext context}) {
  return showDialog(
      context: context,
      barrierColor: Color.fromARGB(99, 5, 2, 2),
      builder: (context) => Center(child: CircularProgressIndicator()));
}

getData({required String keyUser}) {
  final box = GetStorage();
  if (box.hasData(keyUser)) {
    return box.read(keyUser);
  } else {
    return null;
  }
}

getDataWithLoading({required BuildContext context, required String keyUser}) {
  lodingPage(context: context);
  final data = getData(keyUser: keyUser);

  if (data != null) {
    Navigator.of(context).pop();
  }
}
