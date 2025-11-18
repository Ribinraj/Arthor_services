import 'dart:async';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/fetch_assignedcases_bloc/fetch_assignedcases_bloc.dart';
import 'package:arthor/presentation/screens/Adress_verificationpage/adress_verificationpage.dart';
import 'package:arthor/presentation/screens/screen_newcasespage/widgets/loading_shimmerwidget.dart';
import 'package:arthor/widgets/custom_appbar.dart';
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assigned case model
class AssignedCaseModel {
  final String id;
  final String name;
  final String productType;
  final String pinCode;
  final Duration initialTimeRemaining; // Initial time when case was assigned
  final DateTime assignedAt; // When the case was assigned
  final String customerType;
  final String mobileNumber;
  final String city;

  AssignedCaseModel({
    required this.id,
    required this.name,
    required this.productType,
    required this.pinCode,
    required this.initialTimeRemaining,
    DateTime? assignedAt,
    required this.customerType,
    required this.mobileNumber,
    required this.city,
  }) : assignedAt = assignedAt ?? DateTime.now();

  // Calculate deadline from assigned time
  DateTime get deadline => assignedAt.add(initialTimeRemaining);
}

class ScreenAssignedpage extends StatefulWidget {
  const ScreenAssignedpage({super.key});

  @override
  State<ScreenAssignedpage> createState() => _ScreenAssignedpageState();
}

class _ScreenAssignedpageState extends State<ScreenAssignedpage> {
  String? expandedCaseId;
  Timer? _timer;

  // // Sample data with time remaining
  // final List<AssignedCaseModel> assignedCases = [
  //   AssignedCaseModel(
  //     id: 'AC001',
  //     name: 'Rajesh Kumar',
  //     productType: 'Home Loan',
  //     pinCode: '560001',
  //     initialTimeRemaining: const Duration(hours: 5, minutes: 30, seconds: 45),
  //     customerType: 'Individual',
  //     mobileNumber: '+91 98765 43210',
  //     city: 'Bangalore',
  //   ),
  //   AssignedCaseModel(
  //     id: 'AC002',
  //     name: 'Priya Sharma',
  //     productType: 'Personal Loan',
  //     pinCode: '560034',
  //     initialTimeRemaining: const Duration(hours: 2, minutes: 15, seconds: 30),
  //     customerType: 'Salaried',
  //     mobileNumber: '+91 87654 32109',
  //     city: 'Bangalore',
  //   ),
  //   AssignedCaseModel(
  //     id: 'AC003',
  //     name: 'Amit Patel',
  //     productType: 'Business Loan',
  //     pinCode: '560078',
  //     initialTimeRemaining: const Duration(hours: 12, minutes: 45, seconds: 20),
  //     customerType: 'Self Employed',
  //     mobileNumber: '+91 76543 21098',
  //     city: 'Bangalore',
  //   ),
  //   AssignedCaseModel(
  //     id: 'AC004',
  //     name: 'Sneha Reddy',
  //     productType: 'Car Loan',
  //     pinCode: '560095',
  //     initialTimeRemaining: const Duration(minutes: 01, seconds: 10),
  //     customerType: 'Salaried',
  //     mobileNumber: '+91 65432 10987',
  //     city: 'Bangalore',
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    // Update timer every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    context.read<FetchAssignedcasesBloc>().add(
      FetchAssignedcasesInitialFetchingEvent(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String getTimeRemaining(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return "EXPIRED";
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Color getTimerColor(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return Colors.red;
    } else if (difference.inHours < 1) {
      return Colors.red;
    } else if (difference.inHours < 3) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  void handleStartVerification(String caseId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Starting verification for case $caseId'),
        backgroundColor: Appcolors.kprimarycolor,
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {
      expandedCaseId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "Assigned Cases"),
      body: BlocBuilder<FetchAssignedcasesBloc, FetchAssignedcasesState>(
        builder: (context, state) {
          if (state is FetchAssignedcasesLoadingState) {
            return const CaseCardsShimmerLoading(count: 3);
          }
          if (state is FetchAssignedcasesErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: ResponsiveUtils.sp(15),
                    color: Colors.red,
                  ),
                  ResponsiveSizedBox.height20,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(8),
                    ),
                    child: TextStyles.body(
                      text: state.message,
                      color: Colors.red,
                    ),
                  ),
                  ResponsiveSizedBox.height20,
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<FetchAssignedcasesBloc>().add(
                        FetchAssignedcasesInitialFetchingEvent(),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: TextStyles.body(
                      text: "Retry",
                      color: Appcolors.kwhitecolor,
                      weight: FontWeight.w600,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.kprimarycolor,
                      foregroundColor: Appcolors.kwhitecolor,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(6),
                        vertical: ResponsiveUtils.hp(1.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is FetchAssignedcasesSuccesstate) {
            final cases = state.assignedcases;
            if (cases.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox_outlined,
                      size: ResponsiveUtils.sp(15),
                      color: Colors.grey,
                    ),
                    ResponsiveSizedBox.height20,
                    TextStyles.subheadline(
                      text: "No new cases available",
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FetchAssignedcasesBloc>().add(
                  FetchAssignedcasesInitialFetchingEvent(),
                );
              },
              color: Appcolors.kprimarycolor,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(4),
                  vertical: ResponsiveUtils.hp(2),
                ),
                itemCount: cases.length,
                itemBuilder: (context, index) {
                  final caseItem = cases[index];
                  final isExpanded = expandedCaseId == caseItem.caseId;
                  //final timeRemaining = getTimeRemaining(caseItem.deadline);
                  //final timerColor = getTimerColor(caseItem.deadline);
                  //final isExpired = timeRemaining == "EXPIRED";

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                    child: Material(
                      elevation: isExpanded ? 8 : 2,
                      borderRadius: BorderRadiusStyles.kradius15(),
                      shadowColor: Appcolors.kprimarycolor.withOpacity(0.2),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            expandedCaseId = isExpanded
                                ? null
                                : caseItem.caseId;
                          });
                        },
                        borderRadius: BorderRadiusStyles.kradius15(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Appcolors.kwhitecolor,
                            borderRadius: BorderRadiusStyles.kradius15(),
                            border: Border.all(
                              color: isExpanded
                                  ? Appcolors.kprimarycolor
                                  : Colors.grey[200]!,
                              width: isExpanded ? 2 : 1,
                            ),
                          ),
                          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Row - Timer & Action Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ID Badge
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(3),
                                      vertical: ResponsiveUtils.hp(0.6),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Appcolors.kprimarycolor
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadiusStyles.kradius5(),
                                    ),
                                    child: TextStyles.caption(
                                      text: caseItem.caseId,
                                      weight: FontWeight.bold,
                                      color: Appcolors.kprimarycolor,
                                    ),
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //     horizontal: ResponsiveUtils.wp(3),
                                  //     vertical: ResponsiveUtils.hp(.7),
                                  //   ),
                                  //   decoration: BoxDecoration(
                                  //     color: timerColor.withOpacity(0.1),
                                  //     borderRadius: BorderRadiusStyles.kradius10(),
                                  //     border: Border.all(
                                  //       color: timerColor,
                                  //       width: .5,
                                  //     ),
                                  //   ),
                                  //   child: Row(
                                  //     children: [
                                  //       Icon(
                                  //         isExpired
                                  //             ? Icons.warning_rounded
                                  //             : Icons.timer_outlined,
                                  //         size: ResponsiveUtils.sp(4.5),
                                  //         color: timerColor,
                                  //       ),
                                  //       SizedBox(width: ResponsiveUtils.wp(2)),
                                  //       if (!isExpired)
                                  //         TextStyles.caption(
                                  //           text: timeRemaining,
                                  //           weight: FontWeight.bold,
                                  //           color: timerColor,
                                  //         )
                                  //       else
                                  //         TextStyles.caption(
                                  //           text: "Time Out",
                                  //           weight: FontWeight.bold,
                                  //           color: Colors.red,
                                  //         ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),

                              ResponsiveSizedBox.height15,

                              // Name
                              TextStyles.subheadline(
                                text: caseItem.customerName,
                                weight: FontWeight.bold,
                                color: Appcolors.kblackcolor,
                              ),

                              ResponsiveSizedBox.height5,
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: ResponsiveUtils.sp(3.5),
                                    color: Appcolors.ksecondarycolor,
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(2)),
                                  Expanded(
                                    child: TextStyles.body(
                                      text: caseItem.productName,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              // Product Type & Pin Code Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: ResponsiveUtils.sp(3.5),
                                        color: Appcolors.ksecondarycolor,
                                      ),
                                      SizedBox(width: ResponsiveUtils.wp(1)),
                                      TextStyles.body(
                                        text: caseItem.presentAddressPincode,
                                        weight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Appcolors.kbackgroundcolor,
                                      borderRadius:
                                          BorderRadiusStyles.kradius5(),
                                      border: Border.all(
                                        color: Appcolors.ksecondarycolor,
                                        width: .5,
                                      ),
                                    ),
                                    child: TextStyles.caption(
                                      text: caseItem.verificationTypeName,
                                      weight: FontWeight.bold,
                                      color: Appcolors.ksecondarycolor,
                                    ),
                                  ),
                                ],
                              ),

                              // Expanded Details
                              if (isExpanded) ...[
                                ResponsiveSizedBox.height20,

                                Divider(color: Colors.grey[300], thickness: 1),

                                ResponsiveSizedBox.height15,

                                TextStyles.subheadline(
                                  text: "Case Details",
                                  weight: FontWeight.bold,
                                  color: Appcolors.kprimarycolor,
                                ),

                                ResponsiveSizedBox.height15,

                                // Detail Items
                                _buildDetailRow(
                                  icon: Icons.person_outline,
                                  label: "Client Name",
                                  value: caseItem.customerType,
                                ),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.person_outline,
                                  label: "Customer Type",
                                  value: caseItem.customerType,
                                ),
                                ResponsiveSizedBox.height10,

                                _buildDetailRow(
                                  icon: Icons.phone_outlined,
                                  label: "Mobile Number",
                                  value: caseItem.customerPhoneNumber,
                                ),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.phone_outlined,
                                  label: "Alternive Mobile Number",
                                  value: caseItem.alternatePhoneNumber,
                                ),
                                // ResponsiveSizedBox.height10,
                                // _buildDetailRow(
                                //   icon: Icons.phone_outlined,
                                //   label: "Verification Type",
                                //   value: caseItem.mobileNumber,
                                // ),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.location_city_outlined,
                                  label: "Location",
                                  value: caseItem.city,
                                ),

                                ResponsiveSizedBox.height20,

                                // Start Verification Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      CustomNavigation.pushWithTransition(
                                        context,
                                        AddressVerificationPage(
                                          sectionKey: "Present Residence",
                                          verificationTypeId: "1",
                                          caseId: caseItem.caseId,

                                        ),
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.verified_user_outlined,
                                    ),
                                    label: TextStyles.body(
                                      text: "Start Verification",
                                      weight: FontWeight.w600,
                                      color: Appcolors.kwhitecolor,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolors.kprimarycolor,
                                      foregroundColor: Appcolors.kwhitecolor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveUtils.hp(1.8),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusStyles.kradius10(),
                                      ),
                                      elevation: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: ResponsiveUtils.sp(4),
          color: Appcolors.ksecondarycolor,
        ),
        SizedBox(width: ResponsiveUtils.wp(3)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.caption(text: label, color: Colors.grey[600]),
              TextStyles.medium(
                text: value,
                weight: FontWeight.w600,
                color: Appcolors.kblackcolor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
