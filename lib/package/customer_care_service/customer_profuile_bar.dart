import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class CustomerProfileBar extends StatefulWidget {
  final String? profileImagePath;
  final Function()? onTapFunction;
  const CustomerProfileBar(
      {super.key, this.profileImagePath, this.onTapFunction});

  @override
  State<CustomerProfileBar> createState() => _CustomerProfileBarState();
}

class _CustomerProfileBarState extends State<CustomerProfileBar> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTapFunction,
      leading: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadious10,
        ),
        child: Image.asset(widget.profileImagePath??'assets/images/small_profile.png'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adrio Rassel",
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
                height: 0),
          ),
          Text('adriorassel@gmail.com',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      trailing: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadious8,
          border: Border.all(color: BorderRadious8Color),
        ),
        child: Image.asset('assets/icons/notification.png'),
      ),
    );
  }
}