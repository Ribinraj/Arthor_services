import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EnhancedDashboardCardShimmer extends StatelessWidget {
  const EnhancedDashboardCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
        width: ResponsiveUtils.wp(27),
        height: ResponsiveUtils.hp(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusStyles.kradius15(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder
            Container(
              width: ResponsiveUtils.sp(8),
              height: ResponsiveUtils.sp(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            // Number placeholder
            Container(
              width: ResponsiveUtils.wp(15),
              height: ResponsiveUtils.hp(1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(height: ResponsiveUtils.hp(0.8)),
            // Label placeholder
            Container(
              width: ResponsiveUtils.wp(20),
              height: ResponsiveUtils.hp(1.2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
