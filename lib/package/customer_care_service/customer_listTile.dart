import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class CustomerListTile extends StatefulWidget {
  const CustomerListTile({super.key});

  @override
  State<CustomerListTile> createState() => _CustomerListTileState();
}

class _CustomerListTileState extends State<CustomerListTile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          ListTile(
            
            leading: Container(
                height: 30,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.asset('assets/images/small_profile.png')),
            title: Text(
              "Adrio Rassel",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
                height: 0
              ),
            
            ),
            subtitle: Text('adriorassel@gmail.com',style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 0),),
          ),
        ],
      ),
    ));
  }
}
