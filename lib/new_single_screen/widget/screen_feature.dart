import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/const/path.dart';

class ScreenFeature extends StatelessWidget {
  final String path;
  final String featureHeader;
  final String featureDetails;
  const ScreenFeature({
    super.key, required this.path, required this.featureHeader, required this.featureDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Image.asset(path),
                width10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      featureHeader,
                      style: TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w400),
                    ),
                    Text(
                     featureDetails,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
