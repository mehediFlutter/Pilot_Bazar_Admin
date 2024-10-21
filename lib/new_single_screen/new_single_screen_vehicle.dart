import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/new_single_screen/widget/screen_feature.dart';

import '../const/path.dart';

class NewSingleScreenVehicle extends StatefulWidget {
  const NewSingleScreenVehicle({super.key});

  @override
  State<NewSingleScreenVehicle> createState() => _NewSingleScreenVehicleState();
}

class _NewSingleScreenVehicleState extends State<NewSingleScreenVehicle> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenImage(),
              height5,
              Text(
                "Land Cruiser Prado",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              height15,
              ScreenFeature(
                path: '$iconPath/model_icon.png',
                featureHeader: 'Model',
                featureDetails:  "Recon",

              )
            ],
          ),
        ),
      ),
    ));
  }
}

class ScreenImage extends StatelessWidget {
  const ScreenImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/images/new_vehicle_demo.png"),
    );
  }
}

