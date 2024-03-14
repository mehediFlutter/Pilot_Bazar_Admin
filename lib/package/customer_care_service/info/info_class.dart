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
                   header('Model'),
                    detailsOfHeader('C-HE'),
                    detailsOfHeader('Premio'),
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
                    header('Modeo Year'),
                    detailsOfHeader('3434234'),
                  ],
                ),
              ),
            ),
          
          ],
        ),
        height10,
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
                    header('Mileage'),
                    detailsOfHeader('34000n KM'),
                 //   detailsOfHeader('BMW'),
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
                    header('Engine'),
                    detailsOfHeader('2400 cc'),
                   //detailsOfHeader('Premio'),
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
                    header('Available'),
                    detailsOfHeader('PBL'),
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
       Icon(Icons.arrow_forward,size: 12,color: Colors.grey,),
        width5,
        Text(
          name,
          style: small10Style,
        ),
      ],
    );
  }
  
  Image arrowImage(){
    return Image.asset('assets/icons/small_arror.png');
  }
  

  header(String header) {
    return Text(header, style: small12Style);
  }
}
