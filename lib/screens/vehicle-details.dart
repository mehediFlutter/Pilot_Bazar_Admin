import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pilot_bazar_admin/DTO/vehicle_detail_dto.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';

class VehicleDetails extends StatefulWidget {
  final String id;

  const VehicleDetails({
    super.key,
    required this.id,
  });

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  List unicTitle = [];
  List details = [];

  SharedPreferences? preference;
  bool isFeatureDetails = false;
  bool isFeatureInProgress = false;
  List vehicleFeature = [];
  List? vehicleSpecialFeature = [];

  String? vehicleName;
  String? vehiclePrice;
  String? vehicleCode;

  Future specialFeatures() async {
    isFeatureInProgress = true;
    if (mounted) {
      setState(() {});
    }

    preference = await SharedPreferences.getInstance();

    Response response = await get(
      Uri.parse(
          "$APP_APISERVER_URL/api/v1/vendor-management/vehicles/${widget.id}"),
      headers: await {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'application/gzip',
        'Authorization': 'Bearer ${preference?.getString('token')}'
      },
    );

    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    VehicleDetailDTO dto = await VehicleDetailDTO.fromObject(decodedResponse);
    print("Feature DTO Json");
    print(dto.toJson());
    print("DTO to details");
    print(dto.toDetails());
    //   print(dto.feature?[0].title??'None');
    //   print(dto.special?[0].title??'None');
    //  print(dto.gallery?[0].title??'None');
    //  print(dto.gallery?[0].share??'None');

    vehicleName = decodedResponse['title'];
    vehiclePrice = decodedResponse['price'];
    vehicleCode = decodedResponse['code'];
    if (mounted) {
      setState(() {});
    }

    vehicleFeature = decodedResponse['feature'];

    if (decodedResponse['special'] != null) {
      isFeatureDetails = true;
      vehicleSpecialFeature = decodedResponse['special'];
      print("Special features are ${vehicleSpecialFeature}");
      setState(() {});
    }

    if (decodedResponse['gallery'] != null) {
      ImageLinkList = decodedResponse['gallery'];
      setState(() {});
    }

    //  List<dynamic> vehicleFeatures = decodedResponse['feature'];
    isFeatureInProgress = false;
    if (mounted) {
      setState(() {});
    }

    print("Feature title and value:  ${vehicleFeature}");
  }

  final String fallbackImage =
      "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png";

  static Map? todo;

  List<String> lessFeatureTitle = [];
  List<String> lessFeatureDetails = [];

  List imageList = [];
  String? ImageLink;
  List ImageLinkList = [];
  bool _getImages = false;

  initState() {
    super.initState();
    print("hello i am in details page");
    print("ID ${widget.id}");

    specialFeatures();

    if (todo != null) {
      String name = todo?['vehicleName'] ?? '';
      print("Name is");
      print(name);
    }

    _pageController = PageController(initialPage: 0);
    startAutoPlay();
    //getImages();
  }

  getimg() async {
    Response response = await get(
        Uri.parse(
            '${baseUrl}api/merchants/vehicles/products/${widget.id}/detail'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${preference!.getString('token')}'
        });
    print('statuc cdoe');
    print(response.statusCode);
  }

  Timer? _timer;

  void startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentIndex < ImageLinkList.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        setState(() {});
      } else {
        _pageController.jumpToPage(0);
        setState(() {});
      }
    });
  }

  void onTapImage() {
    if (_currentIndex < ImageLinkList.length - 1) {}
  }

  stopAutoPlay() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  restartAutoPlay() {
    if (_timer != null && !_timer!.isActive) {
      startAutoPlay();
    }
  }

  pressedImage() {}

  @override
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    isFeatureInProgress ? '' : vehicleName ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _getImages
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(height: 30),
                          Text(
                            "Please wait images are loagind",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      body: Column(
                                        children: [
                                          Expanded(
                                            child: PhotoViewGallery.builder(
                                              itemCount: ImageLinkList.length,
                                              builder: (context, index) {
                                                return PhotoViewGalleryPageOptions
                                                    .customChild(
                                                  child: Image.network(
                                                    '${ImageLinkList[index]}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      // On error, show fallback image
                                                      return Image.network(
                                                        fallbackImage, // Fallback image URL
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                  minScale:
                                                      PhotoViewComputedScale
                                                          .contained,
                                                  maxScale:
                                                      PhotoViewComputedScale
                                                              .covered *
                                                          2,
                                                );
                                              },
                                              backgroundDecoration:
                                                  BoxDecoration(
                                                color: Colors.black,
                                              ),
                                              pageController: PageController(
                                                initialPage: _currentIndex,
                                              ),
                                              onPageChanged: (index) {
                                                setState(() {
                                                  _currentIndex = index;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                stopAutoPlay();
                              },
                              onLongPressEnd: (details) {
                                restartAutoPlay(); // Restart auto-scrolling when long press ends
                              },
                              child: Container(
                                height: 250,
                                width: double.infinity,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  itemCount: ImageLinkList.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return PhotoView(
                                      imageProvider: NetworkImage(
                                          '${ImageLinkList[index]}'),
                                      minScale:
                                          PhotoViewComputedScale.contained *
                                              1.1, // Adjust as needed
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png', // URL of the error image
                                          fit: BoxFit
                                              .cover, // Adjust the fit to your liking
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                                left: -10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle, // Circular shape
                                    color: Colors.grey.withOpacity(
                                        0.2), // Add background color here
                                  ),
                                  padding: EdgeInsets.all(3.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape:
                                          CircleBorder(), // This makes the button circular
                                      padding: EdgeInsets.all(
                                          8), // Adjust padding inside the button
                                      backgroundColor: Colors
                                          .transparent, // Button background is transparent
                                    ),
                                    onPressed: () {
                                      if (_currentIndex > 0) {
                                        _pageController.previousPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 28,
                                      color: Colors.white, // Icon color
                                    ),
                                  ),
                                )),
                            Positioned(
                              // top: 20,
                              right: -10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Circular shape
                                  color: Colors.grey.withOpacity(
                                      0.2), // Add background color here
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape:
                                          CircleBorder(), // This makes the button circular
                                      padding: EdgeInsets.all(8),
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    if (_currentIndex <
                                        ImageLinkList.length - 1) {
                                      _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ImageLinkList.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          final newPageIndex = index;
                          if (newPageIndex <= ImageLinkList.length) {
                            _pageController.animateToPage(newPageIndex,
                                duration: Duration(microseconds: 300),
                                curve: Curves.easeInOut);
                          }
                          setState(() {});
                          print(index);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${ImageLinkList[index]}',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png", // Fallback image URL
                                fit: BoxFit.cover,
                              );
                            },
                            width: 140,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 178, 224, 179),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        isFeatureInProgress ? '' : vehiclePrice ?? '',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Text(
                      "Negotiable | T&C will be applicable",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Text("Code",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.black, fontSize: 15)),
                        Text(
                            "${vehicleCode}"
                            // todo?['code']??''.toString()
                            ,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
                height20,
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Features :",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationStyle: TextDecorationStyle.solid,
                          )),
                ),
                height10,
                Container(
                    width: double.infinity,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: vehicleFeature.length,
                      itemBuilder: (context, index) {
                        return
                            //  contentPadding: EdgeInsets.zero,
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(vehicleFeature[index]['title'],
                                  style: small14StyleW500),
                            )),
                            //Text(":",style: TextStyle(color: Colors.white),),
                            SizedBox(
                              width: size.width / 20,
                            ),

                            Expanded(
                                child: Text(vehicleFeature[index]['value'],
                                    style: small14StyleW500)),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Color(0xFFEEEEEE),
                            height: 0,
                          ),
                        );
                      },
                    )),
                height20,
                isFeatureDetails
                    ? Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "Special Features",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  // decoration: TextDecoration.underline,
                                  decorationColor:
                                      const Color.fromARGB(255, 175, 173, 173),
                                  fontSize: 20),
                        ),
                      )
                    : SizedBox(),
                isFeatureDetails
                    ? Container(
                        width: double.infinity,
                        child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: vehicleSpecialFeature?.length ?? 0,
                          itemBuilder: (context, index) {
                            print(
                                "length of spcecial feature ${vehicleSpecialFeature?.length}");
                            return Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Text(
                                      vehicleSpecialFeature?[index]['title'],
                                      style: small14StyleW500),
                                )),
                                SizedBox(
                                  width: size.width / 20,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Text(
                                      vehicleSpecialFeature?[index]['value']
                                              .join(', ') ??
                                          '',
                                      style: small14StyleW500),
                                )),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: Color(0xFFEEEEEE),
                              height: 0,
                            );
                          },
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  features_unit_left_side(
    BuildContext context,
    String title,
    String details,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          Text(details, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  features_unit_right_side(BuildContext context, String title, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Spacer(),
          //SizedBox(height: 10,),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          Text(details, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
