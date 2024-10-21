import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class CustomerProfileBar extends StatefulWidget {
  final String profileImagePath;
  final String? notification_image_path;
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
    this.notification_image_path,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
      
          //  onTap: widget.onTapFunction,
          children: [
            Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadious10,
                  ),
                  child: Image.asset(
                    widget.isChatAvater
                        ? widget.chatAvater ?? ''
                        : (widget.profileImagePath.isNotEmpty)
                            ? widget.profileImagePath
                            : errorPerson,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.merchantName ?? 'Kabir Khan',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.companyName ?? 'kabirkhan@example.com',
                     style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              Spacer(),
                SvgPicture.asset(
                  widget.notification_image_path ?? '',
                ),
              ],
            ),
          ]),
    );
  }
}
