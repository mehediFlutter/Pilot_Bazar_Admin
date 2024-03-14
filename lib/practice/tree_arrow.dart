import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Click Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextTab(
                  text: 'Text 1',
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    onTabTapped(0);
                  },
                ),
                SizedBox(width: 20),
                TextTab(
                  text: 'Text 2',
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    onTabTapped(1);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue),
    borderRadius: BorderRadius.circular(10),
  ),
  child: selectedIndex == 0 ? MyWid1() : MyWid2(),
)
            ),
          ],
        ),
      ),
    );
  }
}

class TextTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;

  const TextTab({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          decorationColor: Colors.blue,
          decorationThickness: 2,
        ),
      ),
    );
  }
}

class MyWid1 extends StatelessWidget {
  const MyWid1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("this is class one"),
        Text("this is class one"),
        Text("data"),
        ],
    );
  }
}
class MyWid2 extends StatelessWidget {
  const MyWid2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("this is class two "),
        Text("this is class two"),
        Text("data"),
        ],
    );
  }
}
