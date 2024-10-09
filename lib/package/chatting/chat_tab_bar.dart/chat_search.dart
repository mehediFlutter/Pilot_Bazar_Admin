import 'package:flutter/material.dart';

class SearchBarClass extends StatefulWidget {
  @override
  _SearchBarClassState createState() => _SearchBarClassState();
}

class _SearchBarClassState extends State<SearchBarClass> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}