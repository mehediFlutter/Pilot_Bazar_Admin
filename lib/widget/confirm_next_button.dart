import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class ConfirmAndNextButton extends StatefulWidget {
  final double width;
  final String text;
  final String? arrowOrPlus;
  const ConfirmAndNextButton({super.key, required this.width, required this.text, this.arrowOrPlus});

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
          Text(widget.text,style: small12Stylew500.copyWith(color: Colors.white)),
          Text(widget.arrowOrPlus??'',style: small12Stylew500.copyWith(color: Colors.white,fontSize: 20)),
        ],
      )),
      ),
    );
  }
}