import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  final Map item;
  const ItemDetails({super.key, required this.item});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Text("Details of item"),
          Text("This fruits name is ${widget.item['name']}"),
          Text("This fruits price is ${widget.item['price']}"),

        ],
      ),
    ));
  }
}