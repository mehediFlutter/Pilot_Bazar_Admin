import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pilot_bazar_admin/DTO/get_all_vehicle_dao.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_tab_bar.dart/chat_Tab_bar.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer.dart';
import 'package:pilot_bazar_admin/provider/socket_methode_provider.dart';
import 'package:pilot_bazar_admin/screens/advance_edit_screen.dart';
import 'package:pilot_bazar_admin/screens/auth/auth_utility.dart';
import 'package:pilot_bazar_admin/screens/auth/loain_model.dart';
import 'package:pilot_bazar_admin/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:pilot_bazar_admin/screens/edit_price.dart';
import 'package:pilot_bazar_admin/screens/vehicle-details.dart';
import 'package:pilot_bazar_admin/share_details.dart/share_only_details.dart';
import 'package:pilot_bazar_admin/shimmer_effect/shimmer_effect.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';
import 'package:pilot_bazar_admin/socket_io/socket_method.dart';
import 'package:pilot_bazar_admin/widget/alert_dialog.dart';
import 'package:pilot_bazar_admin/widget/products.dart';
import 'package:pilot_bazar_admin/widget/search_text_fild.dart';
import 'package:pilot_bazar_admin/widget/snack_bar.dart';
import 'package:pilot_bazar_admin/widget/unic_title_and_details_function_class.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

// https://websocket.pilotbazar.xyz/

class SingleVehicleScreen extends StatefulWidget {
  final String? token;
  const SingleVehicleScreen({super.key, this.token});

  @override
  State<SingleVehicleScreen> createState() => _SingleVehicleScreenState();
}

class _SingleVehicleScreenState extends State<SingleVehicleScreen> {
  static late int page;
  static late int i;
  late SharedPreferences prefss;
  String searchValue = '';
  bool searchInProgress = false;
  bool shareInProgress = false;
  late String toki;
  bool _isDeviceConnected = false;
  bool _isAlertShown = false;
  bool showAskingPrice = true;

  int getIntPreef = 0;
  Future<void> getPreffs() async {
    prefss = await SharedPreferences.getInstance();
    if (prefss.getString('token') == null) {
      getIntPreef--;
    } else {
      getIntPreef++;
    }
  }

  Map<String, dynamic>? userInfo;

  // loadUserInfo() async {
  //   LoginModel user = await AuthUtility.getUserInfo();
  //   userInfo = user.toJson();
  //   print("User info ");
  //   print(userInfo);
  //   print(userInfo?['payload']['token']);

  //   setState(() {});
  // }

  LoginModel? userInfoFromPrefs;
  void printUserInfo() async {
    userInfoFromPrefs = await AuthUtility.getUserInfo();
    print("user name is  : ${userInfoFromPrefs?.name}");
  }

  // void _listenToScroolMoments() {
  //   if (scrollController.offset == scrollController.position.maxScrollExtent) {
  //     page++;
  //     setState(() {});
  //     getNewProduct(page);
  //   }
  // }

  bool hasTypedText = false;
  late var socket = SocketManager().socket;
  var socketMethod = SocketMethod();

  String? authorizeTokenChatToken;

  List contactNumber = [];

  Map? syncContactNumbers;
  // pirntSocketChatToken()async {
  //   String token = await socketMethod.authorizeChatToken??'';
  //  print("Authorize chat token from single vehicle screen ");
  //  print(token);
  //   print(socketMethod.authorizeChatToken);
  // }
  List<GetAllVehicleDTO>? vehicleCollection;
  getVehicleCollection() async {
    final provider =
        await Provider.of<SocketMethodProvider>(context, listen: false);
    provider.getVehicleCollectionMethod();
  }

  initState() {
    isRefresh = false;
    page = 1;
    i = 0;
    setState(() {});
    printUserInfo();
    _checkConnectivity();
    // initializePreffsBool();

    // scrollController.addListener(_listenToScroolMoments);

    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        hasTypedText = true;
      }
      if (searchController.text.isEmpty && hasTypedText) {
        page = 1;
        i = 0;
        searchProducts.clear();
        products.clear();

        hasTypedText = false; // Reset the flag
        setState(() {});
      }
    });
    //  pirntSocketChatToken();

    getVehicleCollection();
    Timer.periodic(Duration(seconds: 2), (timer) {
      print("Hello");
      if (socket.id == null) {
        // getMessengeToken();
      }
    });
  }

  getMessengeToken() async {
    await socketMethod.authorizeChat();
    await SocketManager();
  }

  @override
  void dispose() {
    // _subscription.cancel(); // Cancel subscription on dispose
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    try {
      _isDeviceConnected = await InternetConnectionChecker().hasConnection;
      _showAlertDialogIfNeeded();
    } catch (e) {}
  }

  // void _listenForChanges() {
  //   _subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) async {
  //     try {
  //       _isDeviceConnected = await InternetConnectionChecker().hasConnection;
  //       _showAlertDialogIfNeeded();
  //     } catch (e) {
  //       print("Error listening for connectivity changes: $e");
  //     }
  //   });
  // }

  void _showAlertDialogIfNeeded() {
    if (!_isDeviceConnected && !_isAlertShown) {
      _isAlertShown = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          actionsPadding: const EdgeInsets.all(5),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'No Internet Connection',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Axiforma'),
              ),
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please check your internet connection and",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'Axiforma'),
              ),
              Text(
                "try again",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'Axiforma'),
              ),
            ],
          ),
          actions: [
            const Divider(
              thickness: 1, // Adjust thickness as needed
              color: Colors.black26, // Adjust color as needed
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                _isAlertShown = false;
                await _checkConnectivity(); // Recheck after clicking OK
                initState();
              },
              child: const Center(
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 17, fontFamily: 'Axiforma'),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  initializePreffsBool() async {
    await getPreffs();
    setState(() {});
  }

  static List allProductsForSearch = [];
  static List newProductsForSearch = [];

  // ... (rest of your existing code)
  int f = 1;
  void getProductForSearch() async {
    for (f; f < 14; f++) {
      Response response = await get(Uri.parse("${baseUrl}api/vehicle?page=$f"));
      //${baseUrl}api/vehicle?page=0
      //https://crud.teamrabbil.com/api/v1/ReadProduct
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      // print(decodedResponse['data']);
      for (int i = 0; i < decodedResponse['data'].length; i++) {
        allProductsForSearch.add(Product(
          vehicleName:
              decodedResponse['data'][i]?['translate'][0]['title'] ?? '',
          vehicleNameBangla:
              decodedResponse['data'][i]['translate'][1]?['title'] ?? "",
          manufacture: decodedResponse['data'][i]?['manufacture'] ?? '',
          slug: decodedResponse['data'][i]?['slug'] ?? '',
          id: decodedResponse['data'][i]['id'] ?? '',
          condition: decodedResponse['data'][i]?['condition']['translate'][0]
                  ?['title'] ??
              '',
          mileage: decodedResponse['data'][i]?['mileage']['translate'][0]
                  ?['title'] ??
              '',
          price: decodedResponse['data'][i]?['price'] ?? '',
          imageName: decodedResponse['data'][i]?['image']['name'] ?? '',
          registration: decodedResponse['data'][i]?['registration'] ?? '-',
        ));
      }
      setState(() {
        allProductsForSearch;
      });

      //print(allproducts.toString());
    }
  }

  void updateList(String val) {
    setState(() {
      searchValue = val; // Update the search term variable

      if (val.isNotEmpty) {
        newProductsForSearch = List.from(allProductsForSearch);
      } else {
        List<String> searchTerms = val.toLowerCase().split(' ');

        newProductsForSearch = allProductsForSearch.where((element) {
          String combinedText =
              '${element.vehicleName} ${element.manufacture}'.toLowerCase();

          // Check if all search terms are present in the combined text
          return searchTerms.every((term) => combinedText.contains(term));
        }).toList();
      }
    });
  }

  List products = [];

  bool _getProductinProgress = false;
  bool _getNewProductinProgress = false;
  bool _detailsInProgress = false;

  static int x = 0;

  getNewProduct(int page) async {
    _getNewProductinProgress = true;
    // searchProductsIsEmpty = false;
    if (mounted) {
      setState(() {});
    }
    Response? response;

    response = await get(
      Uri.parse('${baseUrl}api/merchants/vehicles/products?page=$page'),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      },
    );

    //${baseUrl}api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    if (decodedResponse['data'].isEmpty) {
      _getNewProductinProgress = false;
      if (mounted) {
        setState(() {});
      }
    }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        if (decodedResponse['data'].isEmpty) {
          _getNewProductinProgress = false;
          if (mounted) {
            setState(() {});
          }
        }
        if (prefss.getString('token') == null) {
          newPrice = (e['fixed_price'] != null && e['fixed_price'] > 0)
              ? (e['fixed_price'] + (e['additional_price'] ?? 0))
              : e['price'];
          //  print(newPrice);
          setState(() {});
        } else {
          newPrice = e['price'];
          setState(() {});
          //  print(newPrice);
        }
        //  List<Product> products = [];
        newPrice = (e['fixed_price'] != null && e['fixed_price'].toInt() > 0)
            ? (e['fixed_price'] + (e['additional_price'] ?? 0))
            : int.parse(e['price'].toString());
        setState(() {});
        products.add(Product(
          vehicleName: e['translate']?[0]?['title'] ?? 'none',
          vehicleNameBangla: e['translate']?[1]?['title'] ?? 'none',
          id: e['id'],
          slug: e['slug'] ?? '',
          manufacture: e['manufacture'] ?? '',
          condition: e['condition']?['translate']?[0]?['title'] ?? '',
          mileage: e['mileage']?['translate']?[0]?['title'].toString() ??
              e['mileages'].toString(),
          price: e['price'].toString() ?? '',
          purchase_price: e['purchase_price'] ?? 0,
          fixed_price: e['fixed_price']?.toString() ?? e['price'].toString(),
          imageName: e['image']?['name'] ?? '',
          registration: e['registration'] ?? 'None',
          engine: e['engine']?['translate']?[0]?['title'] ??
              e['engines'].toString(),
          brandName: e['brand']?['translate']?[0]?['title'] ?? '',
          transmission: e['transmission']?['translate']?[0]?['title'] ?? '',
          fuel: e['fuel']?['translate']?[0]?['title'] ?? '',
          skeleton: e['skeleton']?['translate'][0]?['title'] ?? '',
          available: e['available']?['translate']?[0]?['title'] ?? '',
          code: e['code'] ?? '',
          carColor: e['color']?['translate']?[0]?['title'] ?? 'None',
          edition: e['edition']?['translate']?[0]?['title'] ?? 'None',
          model: e['carmodel']?['translate']?[0]?['title'] ?? '',
          grade: e['grade']?['translate']?[0]?['title'] ?? 'None',
          engineNumber: e['engine_number'] ?? '--',
          chassisNumber: e['chassis_number'] ?? '--',
          video: e['video'] ?? 'No Video',
          engine_id: e['engine_id'].toString() ?? '--',
          onlyMileage: e['mileages'].toString() ?? '--',
          engines: e['engines'].toString() ?? '-',
          newPrice: newPrice.toString(),
          registration_id: e['registration_id'] ?? 9,
          image_id: e['image']?['id'].toString(),
        ));
      });

      x = j + 1;
    }
    for (var item in products) {}
    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (decodedResponse['data'].isEmpty) {
      _getNewProductinProgress = false;
      setState(() {});
    }
  }

  bool isLoading = false;

  String? jsonString;
  bool? isRefresh = false;
  @override
  bool _getDataInProgress = false;
  static List unicTitle = [];
  static List details = [];
  static List imageLInk = [];

  Future getDetails(int id) async {
    prefss = await SharedPreferences.getInstance();

    _getDataInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Response response = await get(
        Uri.parse("${baseUrl}api/merchants/vehicles/products/$id/detail"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        });
    //${baseUrl}api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    List<dynamic> vehicleFeatures = decodedResponse['payload'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
    }
    _getDataInProgress = false;
    if (mounted) {
      setState(() {});
    }
    for (int y = 0; y < unicTitle.length; y++) {
      // print(
      //   unicTitle[y],
      // );
      // print(
      //   details[y],
      // );
    }
  }

  Future<void> shareMedia(String ImageName, vehicleName, manufacture, condition,
      registration, mileage, price, detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("${baseUrl}storage/vehicles/$ImageName");
    final response = await http.get(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);
    late String info;

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:$price ";

    if (unicTitle.length != 0) {
      info = "\n${unicTitle[0]} : ${details[0]}";
      _detailsInProgress = true;
      setState(() {});
      for (int b = 1; b < unicTitle.length; b++) {
        info += "\n${unicTitle[b]} : ${details[b]}";
      }
    }
    await Share.shareXFiles([image],
        text: _detailsInProgress ? message + info : message);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();
    _detailsInProgress = false;
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
    setState(() {});
  }

  static String? detailsLink;
  bool imageInProgress = false;

  Future getLink(int id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }

    prefss = await SharedPreferences.getInstance();

    prefss = await SharedPreferences.getInstance();
    Response? response1;
    if (prefss.getString('token') == null) {
      response1 = await get(
        Uri.parse("${baseUrl}api/clients/vehicles/products/$id/detail"),
      );
    } else {
      response1 = await get(
          Uri.parse("${baseUrl}api/merchants/vehicles/products/$id/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
    }
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);
    detailsLink = decodedResponse1['message'];
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  static List<XFile> showImageList = [];
  late String ImageLink;
  late List ImageLinkList = [];

  bool shareAllImagesInProgress = false;

  Future<void> sendAllImages(String id) async {
    shareAllImagesInProgress = true;
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    try {
      // Fetch vehicle details
      Response? response1 = await get(
        Uri.parse("$APP_APISERVER_URL/api/v1/vendor-management/vehicles/$id"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Encoding': 'application/gzip',
          'Authorization': 'Bearer ${prefss.getString('token')}',
        },
      );

      final decodedResponse1 = jsonDecode(response1.body);
      final gallery = decodedResponse1['gallery'] as List<dynamic>? ?? [];

      if (gallery.isEmpty) {
        shareAllImagesInProgress = false;
        return; // No images to share, exit early
      }

      // Download images concurrently
      List<Future<XFile>> downloadFutures = gallery.map((imageUrl) async {
        final uri = Uri.parse(imageUrl);
        final response = await http.get(uri);
        final imageBytes = response.bodyBytes;

        final tempDirectory = await getTemporaryDirectory();
        final tempFile =
            await File('${tempDirectory.path}/${gallery.indexOf(imageUrl)}.jpg')
                .writeAsBytes(imageBytes);

        return XFile(tempFile.path);
      }).toList();

      // Await all downloads
      showImageList = await Future.wait(downloadFutures);

      // Share images if available
      if (showImageList.isNotEmpty) {
        await Share.shareXFiles(showImageList);

        // Clear temporary data
        unicTitle.clear();
        details.clear();
        shareAllImagesInProgress = false;

        if (mounted) {
          setState(() {});
        }
      }
    } catch (error) {
      // Handle or log error
      print('Error occurred while sharing images: $error');
      shareAllImagesInProgress = false;
    }
  }

  Future<void> shareDetailsWithOneImage(
      int id,
      String ImageName,
      vehicleName,
      manufacture,
      condition,
      registration,
      mileage,
      price,
      newPrice,
      fixed_price,
      detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("${baseUrl}storage/vehicles/$ImageName");
    final response = await http.get(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:${getIntPreef > 0 ? showAskingPrice ? price : fixed_price : newPrice} ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);
    String message3 =
        //"\nOut HotLine Number +${prefss.getString('mobileNumber')}
        "\nShow More\n $detailsLink";
    //  info = "\n${unicTitle[0]} : ${details[0]}";
    //   _detailsInProgress = true;
    setState(() {});
    // for (int b = 1; b < unicTitle.length; b++) {
    //   info += "\n${unicTitle[b]} : ${details[b]}";
    // }

    await Share.shareXFiles([image], text: message + message2 + message3);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareDetailsWithLink(
      int id,
      String ImageName,
      vehicleName,
      manufacture,
      condition,
      registration,
      mileage,
      price,
      newPrice,
      fixed_price,
      detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("${baseUrl}storage/vehicles/$ImageName");
    final response = await http.get(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });

    //await getDetails(widget.id);

    String
        message = // price:${getIntPreef > 0 ? showAskingPrice ?price : fixed_price : newPrice}
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:${getIntPreef >= 0 ? showAskingPrice ? price : fixed_price : newPrice} ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);
    String message3 =
        //"\n\nOut HotLine Number: +${prefss.getString('mobileNumber')}
        "\n\nShow More\n $detailsLink";
    //  info = "\n${unicTitle[0]} : ${details[0]}";
    //   _detailsInProgress = true;
    setState(() {});
    // for (int b = 1; b < unicTitle.length; b++) {
    //   info += "\n${unicTitle[b]} : ${details[b]}";
    // }
    await Share.share(message + message2 + message3);

    // await Share.shareXFiles([image], text: message + message2 + message3);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  // only details share
  Future<void> shareDetails(int id, String ImageName, vehicleName, manufacture,
      condition, registration, mileage, price, detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:$price ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", ";
      }
    }
    print(message2);
    String message3 =
        //"\n\nOur HotLine Number: 0196-99-444-00\n
        " Show More\n $detailsLink";

    setState(() {});

    await Share.share(message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool enterDetailsMethodeWithLotsOfDetails = false;

  Future newGetDetails(int id) async {
    print("get details methode");
    prefss = await SharedPreferences.getInstance();

    shareInProgress = true;
    if (mounted) {
      setState(() {});
    }
//https://pilotbazar.com/api/clients/vehicles/products/features/105
    Response? response;
    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse("${baseUrl}api/clients/vehicles/products/features/$id"),
      );
    } else {
      response = await get(
          Uri.parse("${baseUrl}api/merchants/vehicles/products/features/$id"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
    }
    print("Get Details methodes");
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response!.body);
    List<dynamic> vehicleFeatures = decodedResponse['payload'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);
    if (featureDetailPairs.isNotEmpty) {
      enterDetailsMethodeWithLotsOfDetails = true;
      setState(() {});
    }

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
      // LED,Fog Light, Leather Seat, 5 Seat , Both Front Seat Power, Ponoramic Sun Foof
    }
    shareInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("details length is");
    print(details.length);
    print("End get details methode");
  }

  bool emailInPRogress = false;

  bool emailInProgress = false;

  Future<void> shareViaEmail(int id, String vehicleName, manufacture, condition,
      registration, mileage, price, detailsLink,
      {bool isMedia = false}) async {
    print("Shared via email methode ${imageInProgress}");
    prefss = await SharedPreferences.getInstance();
    showImageList.clear();
    emailInProgress = true;
    setState(() {});
    print('Start of emailInPRogress ${emailInProgress}');

    Response? response1;

    try {
      if (prefss.getString('token') == null) {
        response1 = await get(
          Uri.parse("${baseUrl}api/clients/vehicles/products/$id/detail"),
        );
      } else {
        response1 = await get(
            Uri.parse("${baseUrl}api/merchants/vehicles/products/$id/detail"),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
              'Authorization': 'Bearer ${prefss.getString('token')}'
            });
      }
      print(response1.statusCode);
      final Map<String, dynamic> decodedResponse1 = jsonDecode(response1!.body);
      print("Shared via email methode ${imageInProgress}");

      for (int b = 0; b < decodedResponse1['payload']['gallery'].length; b++) {
        ImageLink = decodedResponse1['payload']["gallery"][b]?['name'] ?? '';
        ImageLinkList.add(ImageLink);
      }

      print("From List Image Links are");
      for (int c = 0; c < ImageLinkList.length; c++) {
        print(ImageLinkList[c]);
      }

      //List<XFile> showImageList = [];
      for (int y = 0; y < ImageLinkList.length; y++) {
        print('loop of image in prpgress emailInPRogress ${emailInProgress}');
        final uri =
            Uri.parse("${baseUrl}storage/galleries/${ImageLinkList[y]}");
        final response = await http.get(uri);
        final imageBytes = response.bodyBytes;
        final tempDirectory = await getTemporaryDirectory();
        // print("Single Image get");
        // print(" ${imageInProgress}");
        final tempFile = await File('${tempDirectory.path}/sharedImage$y.jpg')
            .writeAsBytes(imageBytes);

        final image = XFile(tempFile.path);
        showImageList.add(image);
      }

      print("Length is Unic details");
      print(details.length);
      // final Map<String, dynamic> decodedResponseForFeatures =
      //     jsonDecode(response1.body);
      // List<dynamic> vehicleFeatures =
      //     decodedResponseForFeatures['payload']['vehicle_feature'];

      // List<FeatureDetailPair> featureDetailPairs =
      //     extractFeatureDetails(vehicleFeatures);

      // for (var pair in featureDetailPairs) {
      //   unicTitle.add(pair.featureTitle);
      //   details.add(pair.detailTitles.join(', '));
      // }

      print("details length is");
      print(details.length);
      print("End get details methode");
      String message =
          "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,${isMedia ? '' : 'price:$price'} ";
      print("length of unit title");
      print(unicTitle.length);
      String message2 = '';
      for (int i = 0; i < details.length; i++) {
        message2 += " ${details[i]}";
        if (i < details.length - 1) {
          message2 += ", "; // Add a comma and space if it's not the last index
        }
      }
      print(message2);
      setState(() {});
      print(message2);
      String message3 =
          //"\n\nOur HotLine Number: 0196-99-444-00\n Show More
          "\n $detailsLink";
      if (isMedia == true) {
        message3 = '';
        imageInProgress = false;
        setState(() {});
      }

      if (showImageList.isNotEmpty) {
        // Share all images with text
        await Share.shareXFiles(
            showImageList.map((image) => image as XFile).toList(),
            text: enterDetailsMethodeWithLotsOfDetails
                ? message + message2 + message3
                : message + message3);

        // Clear lists and reset state
        unicTitle.clear();
        details.clear();
        ImageLinkList.clear();
        showImageList.clear();
        enterDetailsMethodeWithLotsOfDetails = false;
        if (mounted) {
          setState(() {});
        }
        print("bool Whare via email loop ${imageInProgress}");
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
    emailInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print('End of emailInPRogress ${emailInProgress}');
  }

  Future<void> shareOnlyDetailsForMedia(
    int id,
    String vehicleName,
    manufacture,
    condition,
    registration,
    mileage,
  ) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage ";
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);

    setState(() {});
    await Share.share(message + message2);

    imageInProgress = false;
    unicTitle.clear();
    details.clear();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareOnlyDetailsWithLink(int id, String vehicleName, manufacture,
      condition, registration, mileage, price) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage Price : $price ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);
    String message3 = "\nShow More\n $detailsLink";

    setState(() {});
    await Share.share(message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  int? newPrice;
  List searchProducts = [];
  bool _searchInProgress = false;
  TextEditingController searchController = TextEditingController();
  // Search

  bool isSearchValue = false;
  Future<void> search(String value) async {
    print("I am search Products methodes");
    searchProducts.clear();
    products.clear();
    if (searchController.text.isEmpty) {}
    _searchInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response? response;

    response = await get(
      Uri.parse(
          '${baseUrl}api/merchants/vehicles/products/search?search=$value'),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      },
    );

    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    final getproductsList = decodedResponse['data'];
    if (decodedResponse['data'].length > 0) {
      isSearchValue = true;
      setState(() {});
    } else {
      isSearchValue = false;
    }

    int i = 0;

    for (i; i < decodedResponse['data'].length; i++) {
      newPrice = (getproductsList[i]['fixed_price'] != null &&
              getproductsList[i]['fixed_price'].toInt() > 0)
          ? (getproductsList[i]['fixed_price'] +
              (getproductsList[i]['additional_price'] ?? 0))
          : int.parse(getproductsList[i]['price'].toString());
      products.add(Product(
        vehicleName: getproductsList[i]?['translate']?[0]?['title'] ?? "none",
        vehicleNameBangla:
            getproductsList[i]?['translate']?[1]?['title'] ?? 'none',
        manufacture: getproductsList[i]?['manufacture'] ?? 'none',
        slug: getproductsList[i]?['slug'] ?? 'none',
        id: getproductsList[i]['id'],
        condition: getproductsList[i]?['condition']?['translate']?[0]
                ?['title'] ??
            "Condition None",
        mileage: getproductsList[i]?['mileage']?['translate']?[0]?['title']
                .toString() ??
            getproductsList[i]['mileages'].toString(),
        //price here
        price: getproductsList[i]?['price'].toString() ?? '',
        purchase_price: getproductsList[i]?['purchase_price'] ?? 0,
        fixed_price: getproductsList[i]?['fixed_price'].toString() ?? '',
        //price end
        imageName: getproductsList[i]?['image']?['name'] ??
            getproductsList[0]?['image']?['name'],
        registration: getproductsList[i]?['registration'] ?? 'None',
        engine: getproductsList[i]?['engines'].toString() ?? '--',
        brandName:
            getproductsList[i]?['brand']?['translate']?[0]?['title'] ?? 'none',
        transmission: getproductsList[i]?['transmission']?['translate']?[0]
                ?['title'] ??
            'none',
        fuel: getproductsList[i]?['fuel']?['translate']?[0]?['title'] ?? 'onne',
        skeleton: getproductsList[i]?['skeleton']?['translate']?[0]?['title'] ??
            'none',
        available:
            getproductsList[i]?['available']?['translate']?[0]?['title'] ?? '',
        code: getproductsList[i]?['code'].toString() ?? '',
        //model: getproductsList,
        carColor:
            getproductsList[i]?['color']?['translate']?[0]?['title'] ?? 'None',
        edition: getproductsList[i]?['edition']?['translate']?[0]?['title'] ??
            'None',
        model:
            getproductsList[i]?['carmodel']?['translate']?[0]?['title'] ?? '',
        grade:
            getproductsList[i]?['grade']?['translate']?[0]?['title'] ?? 'None',
        engineNumber: getproductsList[i]?['engine_number'] ?? 'none',
        chassisNumber: getproductsList[i]?['chassis_number'] ?? 'none',
        video: getproductsList[i]?['video'] ?? 'No Video',
        engine_id: getproductsList[i]?['engine_id'].toString() ?? '12',
        onlyMileage: getproductsList[i]?['mileages'].toString() ?? '--',
        engines: getproductsList[i]?['engines'].toString() ?? '-',
        newPrice: newPrice.toString(),
        registration_id: getproductsList[i]?['registration_id'] ?? 9,
        image_id: getproductsList[i]?['image']?['id'].toString(),
      ));
    }
    products.addAll(searchProducts);
    searchProducts.clear();
    _searchInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (decodedResponse['data'] == null) {
      return;
    }
  }

  bool _availabilityInProgress = false;
  List availableResponseList = [];

  void updateAvailable(int availableID, int index) async {
    prefss = await SharedPreferences.getInstance();

    final body = {
      "available_id": availableID,
    };
    final url =
        "${baseUrl}api/merchants/vehicles/products/${products[x].id}/available";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);
    print(products[x].id);
    print("print from here");
    print(response.statusCode);

    if (response.statusCode == 200) {
      SnackbarUtils.showSnackbar(context, 'Successfully update Availability');
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);

      print("Succesfully Update");
    } else {
      SnackbarUtils.showSnackbar(context, 'Faild to update Availability');
    }
  }

  Future getAvailability() async {
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    Response availableResponse = await get(
        Uri.parse('${baseUrl}api/merchants/vehicles/products/availables'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        });
    print('methode2');
    Map<String, dynamic> decodedAvilableResponse =
        jsonDecode(availableResponse.body);
    final result = decodedAvilableResponse['payload'] as List;
    setState(() {
      availableResponseList = result;
    });
    if (mounted) {
      setState(() {});
    }
  }

  // final ScrollController scrollController = ScrollController();

  bool myBoolValue = true;
  bool fixedPriceChange = false;
  bool askingPriceChange = false;
  bool askingPriceInProgress = false;
  void updateAskingPriceFunction() {
    setState(() {
      myBoolValue = true; // Toggle the value
    });
  }

  void updateFixedPriceFunction() {
    setState(() {
      myBoolValue = false; // Toggle the value
    });
  }

  TextStyle popubItem =
      const TextStyle(color: Colors.black87, fontFamily: 'Roboto');

  @override
  Widget build(BuildContext context) {
    vehicleCollection = Provider.of<SocketMethodProvider>(context, listen: true)
        .getVehicleCollection;
    setState(() {});

    // scrollController.addListener(() {});

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return CustomerProfileBar(
                      profileImagePath: '',
                      notification_image_path:
                          'assets/icons/message_notification.png',
                      chatTap: () async {
                        print(socket.id);
                        socket.id != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabChat()))
                            : showAlertDialogServer(context);
                      },
                      drawer_icon_path: 'assets/icons/beside_message.png',
                      merchantName: userInfoFromPrefs?.name ?? 'None',
                      phone: userInfoFromPrefs?.phone ?? "None",
                    );
                  }),
                  SearchTextFild(
                    searchController: searchController,
                    onSubmit: (value) async {
                      print("onSubmitted: $value");
                      await search(value);
                    },
                  ),
                  height20,
                  Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          isRefresh = true;
                          setState(() {});
                          initState();
                        },
                        child: vehicleCollection?.length != null
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                // controller: scrollController,
                                itemCount: vehicleCollection?.length,
                                itemBuilder: (BuildContext context, index) {
                                  print(
                                      "Vehicle collection length ${vehicleCollection?.length}");
                                  return productList(index, size);
                                },
                              )
                            : SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return ShimmarEffectForSingleVehicle(
                                          isShareOptio: getIntPreef > 0,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialogServer(BuildContext context) async {
    CustomAlertDialog()
        .showAlertDialog(context, "Server is not Availeble  Try Again", 'Ok');
  }

  Center loading() {
    return const Center(
      child: SpinKitFadingCircle(
        color: Colors.grey,
        size: 50.0,
      ),
    );
  }

  productList(int x, Size size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 5, right: 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEEEEEE))),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VehicleDetails(
                      id: vehicleCollection?[x].id ?? 'None',
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: Image.network(vehicleCollection?[x].image??'https://placehold.co/600x400?font=Roboto&text=no+image+found'),
                child: CachedNetworkImage(
                  imageUrl: vehicleCollection?[x].image ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(), // Placeholder widget while loading
                  errorWidget: (context, url, error) => Image.network(
                    "https://placehold.co/600x400?font=Roboto&text=no+image+found",
                    fit: BoxFit.cover, // Fallback image if not found
                  ),
                  fit: BoxFit.cover, // Adjust the image fit as needed
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height5,
                enterSingleData16(vehicleCollection?[x].title),
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
                    enterSingleData(vehicleCollection?[x].registration),
                    width15,
                    dariContainer,
                    width15,
                    enterSingleData(vehicleCollection?[x].condition),
                    width15,
                    Image.asset('assets/icons/mileages.png'),
                    width15,
                    enterSingleData(
                      vehicleCollection?[x].mileage.toString(),
                    ),
                    Text(
                      " KM",
                      style: fontSize14,
                    ),
                  ],
                ),
                height20,
                enterSingleDataSmall(vehicleCollection?[x].available),

                //  height5,
                Row(
                  children: [
                    enterSingleDataSmall('Code :${vehicleCollection?[x].code}'),
                    const Spacer(),
                    PopupMenuButton(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Center(
                              child: shareAllImagesInProgress
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          // value: 20,
                                          ),
                                    )
                                  : Icon(
                                      Icons.more_vert,
                                      size: 20,
                                    )),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Send as Visitor',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);

                                      //    await newGetDetails(products[x + j].id);
                                      await getLink(products[x + j].id);
                                      await shareDetailsWithOneImage(
                                        products[x + j].id,
                                        products[x + j].imageName,
                                        products[x + j].vehicleName,
                                        products[x + j].manufacture,
                                        products[x + j].condition,
                                        products[x + j].registration,
                                        products[x + j].onlyMileage,
                                        products[x + j].price,
                                        products[x + j].newPrice,
                                        products[x + j].fixed_price,
                                        detailsLink,
                                      );
                                    },
                                    child: insidePopubButton(context,
                                        "One Image, Short Details, Link")),
                                height5,
                                InkWell(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await newGetDetails(products[x + j].id);
                                    await getLink(products[x + j].id);
                                    await shareDetailsWithOneImage(
                                      products[x + j].id,
                                      products[x + j].imageName,
                                      products[x + j].vehicleName,
                                      products[x + j].manufacture,
                                      products[x + j].condition,
                                      products[x + j].registration,
                                      products[x].onlyMileage,
                                      products[x + j].price,
                                      products[x + j].newPrice,
                                      products[x + j].fixed_price,
                                      detailsLink,
                                    );
                                  },
                                  child: insidePopubButton(
                                      context, "Taka, Link, Details, Image  "),
                                ),
                                height5,
                                InkWell(
                                  child: insidePopubButton(
                                      context, "Taka, Link, Details"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await newGetDetails(products[x + j].id);
                                    await getLink(products[x + j].id);
                                    await shareDetailsWithLink(
                                        products[x + j].id,
                                        products[x + j].imageName,
                                        products[x + j].vehicleName,
                                        products[x + j].manufacture,
                                        products[x + j].condition,
                                        products[x + j].registration,
                                        products[x].onlyMileage,
                                        products[x + j].price,
                                        products[x + j].newPrice,
                                        products[x + j].fixed_price,
                                        detailsLink);
                                  },
                                ),
                                height5,
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Send as Media (মিডিয়া)',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                InkWell(
                                  child: insidePopubButton(
                                      context, "All Images (শুধু ছবি)"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    print(vehicleCollection?[x].id ?? '');
                                    await sendAllImages(
                                      vehicleCollection?[x].id ?? '',
                                    );
                                  },
                                ),
                                height5,
                                InkWell(
                                    onTap: () async {
                                      SharedPreferences? preferences;
                                      preferences =
                                          await SharedPreferences.getInstance();
                                      Navigator.pop(context);

                                      final feature = await ShareOnlyDetails()
                                          .feature(
                                              vehicleCollection?[x].id ?? '',
                                              preferences.getString('token'));

                                      List values = feature
                                          .map(
                                              (item) => item['value'] as String)
                                          .toList();
                                      String featureValues = values.join(', ');

                                      // final spacialFeature =
                                      //     await ShareOnlyDetails()
                                      //         .specialFeature(
                                      //             vehicleCollection?[x].id ??
                                      //                 '');

                                      // List<String> specialValues = [];
                                      // for (var item in spacialFeature) {
                                      //   if (item['value'] is List) {
                                      //     specialValues.addAll(
                                      //         (item['value'] as List)
                                      //             .map((v) => v.toString()));
                                      //   } else {
                                      //     specialValues
                                      //         .add(item['value'].toString());
                                      //   }
                                      // }

                                      // // Join the values with a comma
                                      // String SpecialfeatureValues =
                                      //     specialValues.join(', ');
                                      // print(SpecialfeatureValues);

                                      await Share.share(featureValues);

                                      // await newGetDetails(
                                      //     products[x + j].id ?? 12);
                                      // await getLink(products[x + j].id ?? 12);
                                      //   await shareOnlyDetailsForMedia(
                                      //     products[x + j].id,
                                      //     products[x + j].vehicleName,
                                      //     products[x + j].manufacture,
                                      //     products[x + j].condition,
                                      //     products[x + j].registration,
                                      //     products[x].onlyMileage);
                                    },
                                    child: insidePopubButton(
                                        context, "Details (শুধু তথ্য)")),
                              ],
                            ))
                          ];
                        }),
                  ],
                ),
                //  height5,
                enterSingleDataSmall('TK : ${vehicleCollection?[x].price}'),
              ],
            ),
            ((getIntPreef <= 0))
                ? SizedBox(
                    height: size.height / 40,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  static int j = x;

  // Update Booked
  void updateBooked(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 20,
    };

    final url =
        "${baseUrl}api/merchants/vehicles/products/${products[index].id}/update/booked";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);
    print(products[index].id);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
      SnackbarUtils.showSnackbar(context, 'Successfully Booked');
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    }
  }

  // delete
  deleteMethode(int id) async {
    prefss = await SharedPreferences.getInstance();
    //  final body = {
    //   "delete_id": 1,
    // };
    print(id);
    final url = "${baseUrl}api/merchants/vehicles/products/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
      SnackbarUtils.showSnackbar(context, 'Successfully Deleted');
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      SnackbarUtils.showSnackbar(context, 'Delete Faild!! try again');
    }
  }

  // Update Sold
  updateSold(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 22,
    };
    final url =
        "${baseUrl}api/merchants/vehicles/products/${products[index].id}/update/sold";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });

    if (response.statusCode == 200) {
      SnackbarUtils.showSnackbar(context, 'Successfully update to Sold');
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBaseScreen()),
          (route) => false);
    } else {
      SnackbarUtils.showSnackbar(context, 'Faild update to Sold');
    }
  }

  navigateToEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => AdvanceScreen(
              id: products[index].id,
              name: products[index].vehicleName.toString(),
              price: products[index].price.toString(),
              manufacture: products[index].manufacture,
              condition: products[index].condition,
              registration: products[index].registration,
              mileage: products[index].mileage,
            ));
    Navigator.push(context, route);
  }

  navigateToPriceEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => PriceEditScreen(
              id: products[index].id,
              name: products[index].vehicleName.toString(),
              price: products[index].price.toString(),
              purchase_price: products[index].purchase_price.toString(),
              fixed_price: products[index].fixed_price.toString(),
            ));
    Navigator.push(context, route);
  }

  Container insidePopubButton(BuildContext context, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 30,
      child: Row(
        children: [
          green10R,
          const SizedBox(width: 10),
          Text(
            name,
            style:
                const TextStyle(fontSize: 12, color: Colors.black87, height: 0),
          ),
        ],
      ),
    );
  }

  Icon green10R = const Icon(
    Icons.circle,
    color: Colors.green,
    size: 10,
  );
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
