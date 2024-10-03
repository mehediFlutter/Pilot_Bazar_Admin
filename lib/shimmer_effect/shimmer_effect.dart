import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:shimmer/shimmer.dart';

class ShimmarEffectForSingleVehicle extends StatelessWidget {
  final bool isShareOptio;
  ShimmarEffectForSingleVehicle({super.key, required this.isShareOptio});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.25),
              highlightColor: Colors.grey.withOpacity(0.5),
              period: Duration(seconds: 1),
              direction: ShimmerDirection.ltr,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerContainer(size, 20, size.width / 2),
                height10,
                shimmerContainer(size, 12, size.width / 2),
                height5,
                shimmerContainer(size, 10, size.width / 2),
                height5,
                shimmerContainer(size, 10, size.width / 2),
                height10
              ],
            ),
          ],
        ),
      ),
    );
  }

  Shimmer shimmerContainer(Size size, double height, double widthQuentity) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.25),
      highlightColor: Colors.grey.withOpacity(0.5),
      period: Duration(seconds: 1),
      direction: ShimmerDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 20),
        child: Container(
          height: height,
          width: widthQuentity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
