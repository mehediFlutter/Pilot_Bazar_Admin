import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/network_service/network_caller.dart';
import 'package:pilot_bazar_admin/network_service/network_response.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/auth/token.dart';
import 'package:pilot_bazar_admin/widget/item.dart';
import 'package:pilot_bazar_admin/widget/products.dart';
import 'package:pilot_bazar_admin/widget/search_text_fild.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleVehicleScreen extends StatefulWidget {
  const SingleVehicleScreen({super.key});

  @override
  State<SingleVehicleScreen> createState() => _SingleVehicleScreenState();
}

class _SingleVehicleScreenState extends State<SingleVehicleScreen> {
  @override
  Map<String, dynamic>? userInfo;
  TextEditingController searchController = TextEditingController();
  late SharedPreferences prefss;
  List<Product> products = [];
  int? newPrice;
  String? token;
  bool _getProductinProgress = false;
  bool searchProductsIsEmpty = false;

  loadUserInfo() async {
    LoginModel user = await AuthUtility.getUserInfo();
    userInfo = user.toJson();
    print("User info ");
    print(userInfo);
    print(userInfo?['payload']['token']);
    token = userInfo?['payload']['token'];
    setState(() {});
  }

  Future getProduct(int page) async {
    prefss = await SharedPreferences.getInstance();
    products.clear();
    _getProductinProgress = true;
    searchProductsIsEmpty = false;
    if (mounted) {
      setState(() {});
    }
    print("Get string token");
    print(prefss.getString('token'));

    Response? response;

    response = await get(
      Uri.parse(
          "https://click4details.com/api/merchants/vehicles/products?page=2"),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}',
      },
    );

    print("STatus code is");
    print(response.statusCode);
    print(response.body);

    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    final getproductsList = decodedResponse['data'];
    print(getproductsList);
    setState(() {});

    for (int i = 0; i < getproductsList.length; i++) {
      print('length of this products');
      // print(decodedResponse['data'].length);

      newPrice = (getproductsList[i]['fixed_price'] != null &&
              getproductsList[i]['fixed_price'].toInt() > 0)
          ? (getproductsList[i]['fixed_price'] +
              (getproductsList[i]['additional_price'] ?? 0))
          : int.parse(getproductsList[i]['price'].toString());
      setState(() {});

      products.add(
        Product(
            vehicleName:
                getproductsList[i]?['translate']?[0]?['title'] ?? 'None',
            vehicleNameBangla:
                getproductsList[i]?['translate']?[1]?['title'] ?? 'None',
            manufacture: getproductsList[i]?['manufacture'] ?? 'none',
            slug: getproductsList[i]?['slug'] ?? 'none',
            id: getproductsList[i]?['id'] ?? 'none',
            condition: getproductsList[i]?['condition']?['translate']?[0]
                    ?['title'] ??
                'none',
            mileage: getproductsList[i]?['mileage']?['translate']?[0]
                    ?['title'] ??
                '--',
            //price here
            price: getproductsList[i]?['price'].toString(),
            purchase_price: getproductsList[i]?['purchase_price'] ?? 0,
            fixed_price: getproductsList[i]?['fixed_price']?.toString() ??
                getproductsList[i]['price'].toString(),
            //price end
            imageName: getproductsList[i]?['image']['name'] ??
                getproductsList[0]?['image']['name'],
            registration: getproductsList[i]?['registration'] ?? 'None',
            engine: getproductsList[i]?['engines'].toString() ?? 'None',
            brandName: getproductsList[i]?['brand']?['translate']?[0]?['title'],
            transmission: getproductsList[i]?['transmission']?['translate']?[0]
                ?['title'],
            fuel: getproductsList[i]?['fuel']?['translate']?[0]?['title'] ??
                'none',
            skeleton: getproductsList[i]?['skeleton']?['translate']?[0]
                    ?['title'] ??
                'none',
            available: getproductsList[i]?['available']?['translate'][0]
                    ?['title'] ??
                'none',
            code: getproductsList[i]?['code'] ?? 'none',
            //model: getproductsList,
            carColor: getproductsList[i]?['color']?['translate']?[0]?['title'] ??
                'None',
            edition: getproductsList[i]?['edition']?['translate']?[0]
                    ?['title'] ??
                'None',
            model: getproductsList[i]?['carmodel']?['translate']?[0]?['title'] ?? '',
            grade: getproductsList[i]?['grade']?['translate']?[0]?['title'] ?? 'None',
            engineNumber: getproductsList[i]?['engine_number'] ?? '--',
            chassisNumber: getproductsList[i]?['chassis_number'] ?? '--',
            video: getproductsList[i]?['video'] ?? 'No Video',
            engine_id: getproductsList[i]?['engine_id'].toString() ?? '12',
            onlyMileage: getproductsList[i]?['mileages'].toString() ?? '--',
            engines: getproductsList[i]?['engines'].toString() ?? '-',
            newPrice: newPrice.toString(),
            registration_id: getproductsList[i]?['registration_id'] ?? 9,
            image_id: getproductsList[i]?['image']?['id'].toString()),
      );
    }

    if (getproductsList == null) {
      return;
    }
    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (getproductsList == null) {
      return;
    }
  }

  void initState() {
    loadUserInfo();
    super.initState();
    getProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Builder(builder: (context) {
                return CustomerProfileBar(
                  profileImagePath: userInfo?['payload']?['merchant']
                          ?['merchant_info']?['image']?['name'] ??
                      '',
                  message_icon_path: 'assets/icons/message_notification.png',
                  drawer_icon_path: 'assets/icons/beside_message.png',
                  merchantName:
                      userInfo?['payload']?['merchant']?['name'] ?? 'None',
                  companyName: userInfo?['payload']?['merchant']
                          ?['merchant_info']['company_name'] ??
                      "None",

                  // onTapFunction: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => CustomerPersonalInfo()));
                  // },
                  // chatTap: () {
                  //   print("notificaiton tap");
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ChatFontScreen()));
                  // },
                  // drawerTap: () {
                  //   Scaffold.of(context).openDrawer();

                  // },
                );
              }),
              SearchTextFild(
                searchController: searchController,
              ),
              height20,
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Item());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
