import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class CustomerListTile extends StatefulWidget {
  const CustomerListTile({super.key});

  @override
  State<CustomerListTile> createState() => _CustomerListTileState();
}

class _CustomerListTileState extends State<CustomerListTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
           CustomerProfileBar(
            profileImagePath: 'assets/images/small_profile.png',
            onTapFunction: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            }
          ),
            height5,
            height5,
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 25),
          child: Container(
           
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEDEDED),
              borderRadius: BorderRadious20,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: TextField(
                style: Theme.of(context).textTheme.bodySmall,
              
                cursorHeight: 15,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                 border: InputBorder.none,
                 prefixIcon: Icon(Icons.search,color: Colors.black,size: 15,)
                ),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    ));
  }
}
