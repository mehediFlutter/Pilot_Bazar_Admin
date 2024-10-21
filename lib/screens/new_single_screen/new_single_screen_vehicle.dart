import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/DTO/get_all_vehicle_dao.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/locagion.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/screen_feature.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/screen_image.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:provider/provider.dart';
import '../../const/path.dart';

class NewSingleScreenVehicle extends StatefulWidget {
  const NewSingleScreenVehicle({super.key});

  @override
  State<NewSingleScreenVehicle> createState() => _NewSingleScreenVehicleState();
}

class _NewSingleScreenVehicleState extends State<NewSingleScreenVehicle> {
  var socketMethod = SocketMethod();
  late var socket = SocketManager().socket;

  List<GetAllVehicleDTO>? vehicleCollection;
  getVehicleCollection() async {
    final provider =
        await Provider.of<SocketMethodProvider>(context, listen: false);
    provider.getVehicleCollectionMethod();
  }

  // getMessengeToken() async {
  //   await socketMethod.authorizeChat();
  //   await SocketManager();
  // }

  @override
  void initState() {
    getVehicleCollection();
    // getMessengeToken();
  }

  @override
  Widget build(BuildContext context) {
    vehicleCollection = Provider.of<SocketMethodProvider>(context, listen: true)
        .getVehicleCollection;
    setState(() {});
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomerProfileBar(
              profileImagePath:        '$imagePath/profile_bar_image.png',
              notification_image_path: '$iconPath/notification_outline.svg',
            ),
            Expanded(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: vehicleCollection?.length,
                itemBuilder: (context, index) {
                  GetAllVehicleDTO singleindex = vehicleCollection![index];
                  return ABc(
                    singleIndex: singleindex,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}





class ABc extends StatelessWidget {
  final GetAllVehicleDTO singleIndex;
  const ABc({
    super.key,
    required this.singleIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenImage(
            imageUrl: singleIndex.image ?? '',
          ),
          SizedBox(height: 8),
          Text(
            singleIndex.title ?? '',
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
                featureDetails: singleIndex.registration ?? 'None',
              ),
              ScreenFeature(
                path: '$iconPath/mileage_icon.png',
                featureHeader: 'MILEAGE',
                featureDetails: "${singleIndex.mileage} KM"  ?? "None",
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
               
                   InkWell(
                    onTap: () {
                      print("Share Button pressed");
                    },
                     child: Container(
                                     height: 32,
                                     width: 88.17,
                                     decoration: BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.circular(5.31)),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                      Image.asset("$iconPath/shareIcon.png"),
                      Text(
                        "Share",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: 'inter'),
                      ),
                                       ],
                                     ),
                                   ),
                   ),
              ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${singleIndex.price ?? 'None'}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                        height: 0),
                  ),
                  Location(
                    available: singleIndex.available ?? 'None',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}
