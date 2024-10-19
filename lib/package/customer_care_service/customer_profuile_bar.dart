import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class CustomerProfileBar extends StatefulWidget {
  final String profileImagePath;
  final String? message_icon_path;
  final String? drawer_icon_path;
  final String? merchantName;
  final String? companyName;
  final String? chatAvater;
  final bool isChatAvater;
  final Function()? onTapFunction;
  final Function()? chatTap;
  final Function()? drawerTap;
  const CustomerProfileBar({
    super.key,
    required this.profileImagePath,
    this.onTapFunction,
    this.chatTap,
    this.message_icon_path,
    this.drawer_icon_path,
    this.drawerTap,
    this.merchantName,
    this.companyName,
    this.chatAvater,
    this.isChatAvater = false,
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
          widget.isChatAvater
              ? widget.chatAvater ?? ''
              : (widget.profileImagePath.isNotEmpty)
                  ? "https://click4details.com/storage/merchants/${widget.profileImagePath}"
                  : errorPerson,
          //  height: 80,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.merchantName ?? 'None',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Color(0xFF444444),
              height: 0,
            ),
          ),
          Text(
            widget.companyName ?? 'None',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // here is the message option temporary comment out
        widget.message_icon_path!=null?  GestureDetector(
            onTap: widget.chatTap,
            child: Container(
              height: 30,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadious8,
                border: Border.all(color: BorderRadious8Color),
              ),
              child: Image.asset(
                widget.message_icon_path ?? '',
              )
            ),
          ):SizedBox(),
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
