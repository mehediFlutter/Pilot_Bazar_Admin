import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

const BorderRadius BorderRadious10 = BorderRadius.all(Radius.circular(10));
const BorderRadius BorderRadious8 = BorderRadius.all(Radius.circular(8));
const BorderRadius BorderRadious20 = BorderRadius.all(Radius.circular(20));
const Color BorderRadious8Color = Color(0xFFEEEEEE);
const SizedBox height5 = SizedBox(height: 5);
const SizedBox height10 = SizedBox(height: 10);
const SizedBox width5 = SizedBox(width: 5);
const SizedBox width10 = SizedBox(width: 10);
const SizedBox width20 = SizedBox(width: 20);
Container horizontalLine = Container(
  height: 55,
  width: 2,
  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
);

Container greenTolu = Container(
  height: 8,
  width: 8,
  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
);

Icon syncIcon = const Icon(
  Icons.sync,
  size: 15,
  color: syncIconColor,
);
Padding syncIconMethode() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: syncIcon,
  );
}
