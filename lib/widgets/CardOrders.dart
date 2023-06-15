import 'package:flutter/material.dart';

class CardOrders extends StatelessWidget {
  const CardOrders({super.key, required this.order});
  final Map order;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      child: ListTile(
      

        tileColor: Colors.grey,
        title: Text("Title : "+order["title"],),
        subtitle: Text("Content : "+order["content"]),
        trailing: Text("Creat At  : "+order["create_at"]),
        textColor: Colors.white,
      ),
    );
  }
}