import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/new_single_screen/widget/locagion.dart';
import 'package:pilot_bazar_admin/new_single_screen/widget/screen_feature.dart';
import 'package:pilot_bazar_admin/new_single_screen/widget/screen_image.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerProfileBar(
                profileImagePath: '$imagePath/profile_bar_image.png',
                notification_image_path: '$iconPath/notification_outline.svg',
              ),
              ScreenImage(),
              SizedBox(height: 8),
              Text(
                "Land Cruiser Prado",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScreenFeature(
                    path: '$iconPath/model_icon.png',
                    featureHeader: 'MODEL',
                    featureDetails: "Recon",
                  ),
                  ScreenFeature(
                    path: '$iconPath/register_icon.png',
                    featureHeader: 'REGISTRATION',
                    featureDetails: "2017",
                  ),
                  ScreenFeature(
                    path: '$iconPath/mileage_icon.png',
                    featureHeader: 'MILEAGE',
                    featureDetails: "35,000 km",
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Spacer(),
                  Text(
                    "BDT 19,500,000",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter'),
                  ),
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      Container(
                      height: 24,
                      width: 76.17,
                      decoration: BoxDecoration(
                          color: Color(0xFF000000),
                          borderRadius: BorderRadius.circular(3.31)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("$iconPath/shareIcon.png"),
                          Text(
                            "Share",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'inter'),
                          ),
                        ],
                      ),
                      ),
                  Location(
                    available: "Mongla Port",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
