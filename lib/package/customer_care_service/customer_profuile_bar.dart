import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class CustomerProfileBar extends StatefulWidget {
  final String? profileImagePath;
  final String? message_icon_path;
  final String? drawer_icon_path;
  final String? companyName;
  final String? phoneNumber;
  final Function()? onTapFunction;
  final Function()? chatTap;
  final Function()? drawerTap;
  const CustomerProfileBar({
    super.key,
    this.profileImagePath,
    this.onTapFunction,
    this.chatTap,
    this.message_icon_path,
    this.drawer_icon_path,
    this.drawerTap,
    this.companyName,
    this.phoneNumber,
  });

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
        decoration: const BoxDecoration(
          borderRadius: BorderRadious10,
        ),
        child: Image.network(
            "https://click4details.com/storage/merchants/${widget.profileImagePath}"),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.companyName ?? 'None',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Color(0xFF444444),
              height: 0,
            ),
          ),
          Text(
            widget.phoneNumber ?? 'None',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.chatTap,
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
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              height: 30,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadious8,
                border: Border.all(color: BorderRadious8Color),
              ),
              child: Image.asset(
                widget.drawer_icon_path ?? 'assets/icons/notification.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
