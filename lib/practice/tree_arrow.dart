import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool showContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showContainer = !showContainer;
                });
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Button',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: showContainer ? 200 : 0,
              width: 200,
              color: Colors.grey,
              curve: Curves.easeOutBack,
              child: Center(
                child: Text(
                  'Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}