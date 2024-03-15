import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class ConfirmAndNextButton extends StatefulWidget {
  final double? width;
  const ConfirmAndNextButton({super.key, this.width});

  @override
  State<ConfirmAndNextButton> createState() => _ConfirmAndNextButtonState();
}

class _ConfirmAndNextButtonState extends State<ConfirmAndNextButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(height: 38,
      width: widget.width,
      decoration: BoxDecoration(
        color: Color(0xFF313131),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Confirm",style: small12Stylew500.copyWith(color: Colors.white)),
          Text(" +",style: small12Stylew500.copyWith(color: Colors.white,fontSize: 20)),
        ],
      )),
      ),
    );
  }
}