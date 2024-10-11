import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer circularChat() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.25),
    highlightColor: Colors.grey.withOpacity(0.5),
    period: Duration(seconds: 1),
    direction: ShimmerDirection.ltr,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
    ),
  );
}
