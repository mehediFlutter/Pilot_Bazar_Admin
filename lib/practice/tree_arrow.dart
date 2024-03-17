import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class ProfileBanner extends StatefulWidget {
  final Function()? drawerTap;
  final String iconPath;

  const ProfileBanner({
    super.key,
    this.drawerTap,
    required this.iconPath,
  });

  @override
  State<ProfileBanner> createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<ProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: GestureDetector(
        onTap: widget.drawerTap,
        child: Container(
          height: 30,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadious8,
            border: Border.all(color: BorderRadious8Color),
          ),
          child: Image.asset(widget.iconPath),
        ),
      ),
    );
  }
}
