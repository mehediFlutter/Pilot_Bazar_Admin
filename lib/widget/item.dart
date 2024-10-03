import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/widget/products.dart';

class Item extends StatefulWidget {
  final Product indexItem;
  const Item({super.key, required this.indexItem});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFEEEEEE))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                'https://pilotbazar.com/storage/galleries/65e584ecc47d6.jpeg'),
          ),
          height5,
          enterSingleData16(widget.indexItem.vehicleName.toString()),
          height5,
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF666666)),
                child: Center(
                  child: Text("R", style: registrationR),
                ),
              ),
              width15,
              enterSingleData("2017"),
              width15,
              dariContainer,
              width15,
              enterSingleData('Recon'),
              width15,
              Image.asset('assets/icons/mileages.png'),
              width15,
              enterSingleData('35000'),
              Text(
                " KM",
                style: fontSize14,
              ),
            ],
          ),
          height20,
          enterSingleDataSmall('Mongla Port'),

          //  height5,
          Row(
            children: [
              enterSingleDataSmall('Code : PBL-90'),
              const Spacer(),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {},
                    child: Center(child: Icon(Icons.more_vert))),
              ),
            ],
          ),
          //  height5,
          enterSingleDataSmall('TK : 9850000'),
        ],
      ),
    );
  }

  Text enterSingleData(String? data) {
    return Text(
      '$data',
      style: fontSize14,
    );
  }

  Text enterSingleData16(String? data) {
    return Text(
      '$data',
      style: fontSize14.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Text enterSingleDataSmall(String? data) {
    return Text(
      '$data',
      style: fontSize12FW400.copyWith(height: 0),
    );
  }
}
