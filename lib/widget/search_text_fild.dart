import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class SearchTextFild extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String>? onChanged;
  const SearchTextFild(
      {super.key, required this.searchController, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadious20,
      ),
      child: TextField(
        cursorColor: Colors.black,
        cursorWidth: 1.2,
        controller: searchController,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodySmall,
        cursorHeight: 15,
        decoration: InputDecoration(
            enabledBorder: searchBarBorder,
            focusedBorder: searchBarBorder,
            contentPadding: const EdgeInsets.only(
              top: 8,
            ),
            hintText: "Search",
            hintStyle: Theme.of(context).textTheme.bodySmall,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 15,
              ),
            )),
      ),
    );
    ;
  }
}
