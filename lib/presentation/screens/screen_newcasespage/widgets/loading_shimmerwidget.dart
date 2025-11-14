import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:flutter/material.dart';

class ShimmerCaseCard extends StatefulWidget {
  const ShimmerCaseCard({super.key});

  @override
  State<ShimmerCaseCard> createState() => _ShimmerCaseCardState();
}

class _ShimmerCaseCardState extends State<ShimmerCaseCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadiusStyles.kradius15(),
        child: Container(
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            borderRadius: BorderRadiusStyles.kradius15(),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildShimmerBox(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.hp(2),
                      ),
                      SizedBox(width: ResponsiveUtils.wp(2)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerBox(
                            width: ResponsiveUtils.wp(25),
                            height: ResponsiveUtils.hp(1.5),
                          ),
                          SizedBox(height: ResponsiveUtils.hp(0.5)),
                          _buildShimmerBox(
                            width: ResponsiveUtils.wp(20),
                            height: ResponsiveUtils.hp(1.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildShimmerBox(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.hp(3),
                        radius: 20,
                      ),
                      SizedBox(width: ResponsiveUtils.wp(2)),
                      _buildShimmerBox(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.hp(3),
                        radius: 20,
                      ),
                    ],
                  ),
                ],
              ),
              
              ResponsiveSizedBox.height15,
              
              // ID Badge
              _buildShimmerBox(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(2.5),
                radius: 5,
              ),
              
              ResponsiveSizedBox.height10,
              
              // Name
              _buildShimmerBox(
                width: ResponsiveUtils.wp(45),
                height: ResponsiveUtils.hp(2.5),
              ),
              
              ResponsiveSizedBox.height10,
              
              // Product Type & Pin Code Row
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildShimmerBox(
                          width: ResponsiveUtils.wp(8),
                          height: ResponsiveUtils.hp(2),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(2)),
                        _buildShimmerBox(
                          width: ResponsiveUtils.wp(30),
                          height: ResponsiveUtils.hp(2),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _buildShimmerBox(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.hp(2),
                      ),
                      SizedBox(width: ResponsiveUtils.wp(1)),
                      _buildShimmerBox(
                        width: ResponsiveUtils.wp(15),
                        height: ResponsiveUtils.hp(2),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: _buildShimmerGradient(),
      ),
    );
  }

  Widget _buildShimmerGradient() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: -1.0, end: 2.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return FractionallySizedBox(
          widthFactor: 1.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[100]!,
                  Colors.grey[300]!,
                ],
                stops: [
                  (value - 0.3).clamp(0.0, 1.0),
                  value.clamp(0.0, 1.0),
                  (value + 0.3).clamp(0.0, 1.0),
                ],
              ),
            ),
          ),
        );
      },
      onEnd: () {
        // Restart animation
        if (mounted) {
          setState(() {});
        }
      },
    );
  }
}

// Loading Widget to show multiple shimmer cards
class CaseCardsShimmerLoading extends StatelessWidget {
  final int count;
  
  const CaseCardsShimmerLoading({
    super.key,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(4),
        vertical: ResponsiveUtils.hp(2),
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return const ShimmerCaseCard();
      },
    );
  }
}