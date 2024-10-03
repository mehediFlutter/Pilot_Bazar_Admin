import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Small3ShimmerContainer extends StatelessWidget {
  const Small3ShimmerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              shimmer3Container(),
              shimmer3Container(),
              shimmer3Container(),
            ],
          ),
        ],
      ),
    );
  }

  Flexible shimmer3Container() {
    return Flexible(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.25),
        highlightColor: Colors.grey.withOpacity(0.5),
        period: Duration(seconds: 1),
        direction: ShimmerDirection.ltr,
        child: Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
