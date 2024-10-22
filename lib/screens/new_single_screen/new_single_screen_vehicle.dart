import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/DTO/get_all_vehicle_dao.dart';
import 'package:pilot_bazar_admin/provider/feature_provider.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/locagion.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/screen_feature.dart';
import 'package:pilot_bazar_admin/screens/new_single_screen/widget/screen_image.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/screens/vehicle-details.dart';
import 'package:pilot_bazar_admin/share_details.dart/share_only_details.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/socket_io/tokens.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/path.dart';

class NewSingleScreenVehicle extends StatefulWidget {
  const NewSingleScreenVehicle({super.key});

  @override
  State<NewSingleScreenVehicle> createState() => _NewSingleScreenVehicleState();
}

class _NewSingleScreenVehicleState extends State<NewSingleScreenVehicle> {
  var socketMethod = SocketMethod();
  late var socket = SocketManager().socket;
  LoginModel? userInfoFromPreference;
  SharedPreferences? preferences;

  List<GetAllVehicleDTO>? vehicleCollection;
  getVehicleCollection() async {
    final provider =
        await Provider.of<SocketMethodProvider>(context, listen: false);
    provider.getVehicleCollectionMethod();
  }

  void printUserInfo() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {});
    userInfoFromPreference = await AuthUtility.getUserInfo();

    print("user name is  : ${userInfoFromPreference?.name}");
    // print(userInfoFromPreference.)
  }

  // getMessengeToken() async {
  //   await socketMethod.authorizeChat();
  //   await SocketManager();
  // }

  @override
  void initState() {
    printUserInfo();
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
              profileImagePath: userInfoFromPreference?.image ?? '',
              merchantName: userInfoFromPreference?.name ?? '',
              phone: userInfoFromPreference?.phone ?? '',
              notification_image_path: '$iconPath/notification_outline.svg',
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: () async {
                    initState();
                    print("Refresh");
                  },
                  child: vehicleCollection?.isNotEmpty == true
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: vehicleCollection?.length,
                          itemBuilder: (context, index) {
                            (vehicleCollection == null ||
                                vehicleCollection!.isEmpty);
                            GetAllVehicleDTO? vehicleDTO =
                                vehicleCollection?[index];
                            if (vehicleDTO == null) {
                              return Container();
                            }
                            return ABc(
                              product: vehicleDTO,
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
          ],
        ),
      ),
    ));
  }
}

class ABc extends StatefulWidget {
  final GetAllVehicleDTO product;
  const ABc({
    super.key,
    required this.product,
  });

  @override
  State<ABc> createState() => _ABcState();
}

class _ABcState extends State<ABc> {
  bool isFirstSendItemSelected = false;
  bool isSecondSendItemSelected = false;
  bool isThirdSendItemSelected = false;
  bool isFourSendItemSelected = false;
  bool isFiveSendItemSelected = false;
  List? vehicleSpecialFeature;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    print(vehicleSpecialFeature);
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleDetails(
              id: widget.product.id ?? 'None',
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenImage(
              imageUrl: widget.product.image ?? '',
              code: widget.product.code ?? '',
            ),
            SizedBox(height: 8),
            Text(
              widget.product.title ?? '',
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
                  featureDetails: widget.product.registration ?? 'None',
                ),
                ScreenFeature(
                  path: '$iconPath/mileage_icon.png',
                  featureHeader: 'MILEAGE',
                  featureDetails: "${widget.product.mileage}" ?? "None",
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
                      onTap: () async {
                        SharedPreferences? preferences;
                        preferences = await SharedPreferences.getInstance();
                        final feature = await Provider.of<FeatureProvider>(
                            context,
                            listen: false);
                        await feature.featureProvider(widget.product.id ?? '',
                            preferences.getString('token'));

                        showModalBottomSheet(
                          useSafeArea: true,
                     
                          context: context,
                          builder: (context) {
                            isFirstSendItemSelected = false;
                            isSecondSendItemSelected = false;
                            isThirdSendItemSelected = false;
                            isFourSendItemSelected = false;
                            isFiveSendItemSelected = false;

                            return DraggableScrollableSheet(
                                initialChildSize: 1, // Start at half screen
                                minChildSize:
                                    0.5, // Minimum size when collapsed
                                maxChildSize:
                                    1.0, // Maximum size when fully expanded
                                builder: (context, scrollController) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 15, right: 15),
                                        child: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 12,
                                                    bottom: 8),
                                                child: Text(
                                                  "Send as Visitor",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              sendMethod(() async {
                                                //first send method
                                                isFirstSendItemSelected =
                                                    !isFirstSendItemSelected;
                                                isSecondSendItemSelected =
                                                    false;
                                                isThirdSendItemSelected = false;
                                                isFourSendItemSelected = false;
                                                isFiveSendItemSelected = false;
                                                setState(() {});

                                                await ShareOnlyDetails()
                                                    .shareDetailsWithOneImage(
                                                        loginToken,
                                                        widget.product.image ??
                                                            '',
                                                        await feature
                                                            .getFeature);
                                              }, 'One Image, Short Details, Link',
                                                  isFirstSendItemSelected),
                                              sendMethod(() async {
                                                isFirstSendItemSelected = false;
                                                isSecondSendItemSelected =
                                                    !isSecondSendItemSelected;
                                                isThirdSendItemSelected = false;
                                                isFourSendItemSelected = false;
                                                isFiveSendItemSelected = false;
                                                setState(() {});
                                                SharedPreferences? preferences;
                                                preferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await ShareOnlyDetails()
                                                    .shareDetailsWithOneImage(
                                                        loginToken,
                                                        widget.product.image ??
                                                            '',
                                                        await feature
                                                                .getFeature +
                                                            await feature
                                                                .getSpecialFeature);
                                              }, 'Taka, Link, Details, Image',
                                                  isSecondSendItemSelected),
                                              sendMethod(() async {
                                                isFirstSendItemSelected = false;
                                                isSecondSendItemSelected =
                                                    false;
                                                isThirdSendItemSelected =
                                                    !isThirdSendItemSelected;
                                                isFourSendItemSelected = false;
                                                isFiveSendItemSelected = false;
                                                setState(() {});
                                                await Share.share(
                                                    await feature.getFeature +
                                                        await feature
                                                            .getSpecialFeature);
                                              }, 'Taka, Link, Details',
                                                  isThirdSendItemSelected),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    top: 12,
                                                    bottom: 8),
                                                child: Text(
                                                  "Send as Media",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              sendMethod(() async {
                                                isFirstSendItemSelected = false;
                                                isSecondSendItemSelected =
                                                    false;
                                                isThirdSendItemSelected = false;
                                                isFourSendItemSelected =
                                                    !isFourSendItemSelected;
                                                isFiveSendItemSelected = false;
                                                setState(() {});
                                                await feature.sendAllImages(
                                                    widget.product.id ?? '',
                                                    await feature.getGallery);
                                                await feature.getGallery;
                                              }, 'All Image',
                                                  isFourSendItemSelected),
                                              sendMethod(() async {
                                                isFirstSendItemSelected = false;
                                                isSecondSendItemSelected =
                                                    false;
                                                isThirdSendItemSelected = false;
                                                isFourSendItemSelected = false;
                                                isFiveSendItemSelected =
                                                    !isFiveSendItemSelected;
                                                setState(() {});

                                                await Share.share(
                                                    await feature.getFeature +
                                                        await feature
                                                            .getSpecialFeature);
                                              }, 'Details',
                                                  isFiveSendItemSelected),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                        );
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${widget.product.price ?? 'None'}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'inter',
                          height: 0),
                    ),
                    Location(
                      available: widget.product.available ?? 'None',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }

  sendMethod(Function() onTap, name, bool colorChangeBool) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.all(4),
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: colorChangeBool ? Colors.black : Color(0xFFE9E9E9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    border:
                        colorChangeBool ? null : Border.all(color: Colors.grey),
                    color: colorChangeBool ? Colors.black : Colors.white,
                    shape: BoxShape.circle),
                child: colorChangeBool
                    ? Center(
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      )
                    : SizedBox()),
          ],
        ),
      ),
    );
  }
}

class SelectBottom extends StatelessWidget {
  const SelectBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Center(
          child: Container(
            height: 8,
            width: 8,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}

class UnSelectedBottom extends StatelessWidget {
  const UnSelectedBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFABABAB)),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            )),
      ),
    );
  }
}
