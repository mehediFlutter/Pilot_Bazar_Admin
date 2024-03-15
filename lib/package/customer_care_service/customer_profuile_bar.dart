import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/drawer/drawer_screen.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/text_fields_screen.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class CustomerProfileBar extends StatefulWidget {
  final String? profileImagePath;
  final String? message_icon_path;
  final String? beside_message_icon_path;
  final Function()? onTapFunction;
  final Function()? chatTap;
  final Function()? drawerTap;
  const CustomerProfileBar(
      {super.key,
      this.profileImagePath,
      this.onTapFunction,
      this.chatTap,
      this.message_icon_path,
      this.beside_message_icon_path, this.drawerTap, });

  @override
  State<CustomerProfileBar> createState() => _CustomerProfileBarState();
}

class _CustomerProfileBarState extends State<CustomerProfileBar> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: widget.onTapFunction,
      leading: Container(
        height: 30,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadious10,
        ),
        child: Image.asset(
          widget.profileImagePath ?? 'assets/images/small_profile.png',
        ),
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
              height: 0,
            ),
          ),
          Text(
            'adriorassel@gmail.com',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap:widget.chatTap,
            child: Container(
              height: 30,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadious8,
                border: Border.all(color: BorderRadious8Color),
              ),
              child: Image.asset(
                widget.message_icon_path ?? 'assets/icons/notification.png',
              ),
            ),
          ),
          SizedBox(width: 10),
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap:
                  widget.drawerTap,
                child: Container(
                  height: 30,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadious8,
                    border: Border.all(color: BorderRadious8Color),
                  ),
                  child: Image.asset(
                    widget.beside_message_icon_path ??
                        'assets/icons/notification.png',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

