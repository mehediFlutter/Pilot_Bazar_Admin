import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class CustomerRequiredTextFild extends StatefulWidget {
  final TextEditingController textFildController;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final Function(dynamic)? function;
  final Function()? onTap;
  final bool readOnly;

  const CustomerRequiredTextFild(
      {super.key,
      required this.textFildController,
      this.hintText,
      this.labelText,
      this.function,
      this.keyboardType,
      this.onTap,
      this.readOnly = false});

  @override
  State<CustomerRequiredTextFild> createState() =>
      _CustomerRequiredTextFildState();
}

class _CustomerRequiredTextFildState extends State<CustomerRequiredTextFild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          if (widget.function != null) {
            widget.function!(value);
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap;
          }
        },

        style: small12Stylew400,

        controller: widget.textFildController,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 20),
            hintText: widget.hintText,
            labelText: widget.labelText,
            hintStyle: small12Stylew400,
            labelStyle: small12Stylew400,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey))),
        cursorColor: Colors.black,
        cursorWidth: 1,
        // cursorHeight: 20,
      ),
    );
  }
}
