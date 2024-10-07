import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatFrontScreenShimmer extends StatelessWidget {
  const ChatFrontScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 105, 94, 94).withOpacity(0.25),
        highlightColor: const Color.fromARGB(255, 61, 52, 52).withOpacity(0.5),
        period: Duration(seconds: 1),
        direction: ShimmerDirection.ltr,
        child: Container(
          height: 45.05,
          width: 40,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 82, 49, 49), shape: BoxShape.circle),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              shimmerMethod(size, 45, double.infinity),
              const Spacer(),
               shimmerMethod(size, 20, double.infinity),
            ],
          ),
          Row(
            children: [
              shimmerMethod(size, 45, double.infinity),
              const Spacer(),
              Image.asset(
                'assets/icons/seenMessage.png',
                color: Colors.blue,
              )
            ],
          ),
        ],
      ),
    );
  }

  Shimmer shimmerMethod(Size  size , double hight,width) {
    return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.25),
              highlightColor: Colors.grey.withOpacity(0.5),
              period: Duration(seconds: 1),
              direction: ShimmerDirection.ltr,
              child: Container(
                height: 45.05,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Colors.grey),
              ),
            );
  }
}
