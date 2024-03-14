import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class InfoDetailsClass extends StatefulWidget {
  final double widthside;
  const InfoDetailsClass({super.key, required this.widthside});

  @override
  State<InfoDetailsClass> createState() => _InfoDetailsClassState();
}

class _InfoDetailsClassState extends State<InfoDetailsClass> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('Brand'),
                    detailsOfHeader('toyota'),
                    detailsOfHeader('bmw'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('terte'),
                    detailsOfHeader('toysdfota'),
                    detailsOfHeader('sdfsd'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('ere'),
                    detailsOfHeader('3434234'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('Brand'),
                    detailsOfHeader('err'),
                    detailsOfHeader('bmw'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('terte'),
                    detailsOfHeader('sada'),
                    detailsOfHeader('bmsdfsdfsw'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('Braadfand'),
                    detailsOfHeader('3434234'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row detailsOfHeader(String name) {
    return Row(
      children: [
        width5,
        greenTolu,
        width5,
        Text(
          name,
          style: small10Style,
        ),
      ],
    );
  }

  header(String header) {
    return Text(header, style: small12Style);
  }
}
