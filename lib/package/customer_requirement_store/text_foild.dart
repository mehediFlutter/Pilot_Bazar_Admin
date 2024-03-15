import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class CustmerRequiredTextFild extends StatefulWidget {
  final TextEditingController customerNameController;
  final String? hintTextForCustomerNameController;
  final Function(dynamic)? function;

  const CustmerRequiredTextFild(
      {super.key,
      required this.customerNameController,
      this.hintTextForCustomerNameController,
      this.function});

  @override
  State<CustmerRequiredTextFild> createState() =>
      _CustmerRequiredTextFildState();
}

class _CustmerRequiredTextFildState extends State<CustmerRequiredTextFild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onChanged: (value) {
          if (widget.function != null) {
            widget.function!(value);
          }
        },
      
        style: small10Style,
      
        controller: widget.customerNameController,
        decoration: InputDecoration(
            prefix: SizedBox(
              width: 20,
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            hintText: widget.hintTextForCustomerNameController,
            hintStyle: small10Style.copyWith(fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xFFEEEEEE))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey))
                ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        // cursorHeight: 20,
      ),
    );
  }
}
