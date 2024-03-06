import 'package:flutter/material.dart';

class NotificaitonScreen extends StatefulWidget {
  const NotificaitonScreen({super.key});

  @override
  State<NotificaitonScreen> createState() => _NotificaitonScreenState();
}

class _NotificaitonScreenState extends State<NotificaitonScreen> {
  List customerList = [
    'customer1,,,,,,'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Column(
      children: [
          Expanded(
              child: ListView.builder(
               primary: false,
               // shrinkWrap: false,
                 scrollDirection: Axis.vertical,
                  itemCount: customerList.length,
                  itemBuilder: (context, index) {
                    return Text(customerList[index]);
                  }),
            ),
      ],
    ),));
  }
}