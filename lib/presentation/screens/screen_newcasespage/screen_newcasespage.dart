
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/case_accept_decline_bloc/case_accept_decline_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_newcases_bloc/fetch_newcases_bloc.dart';
import 'package:arthor/presentation/screens/screen_newcasespage/widgets/loading_shimmerwidget.dart';
import 'package:arthor/widgets/custom_appbar.dart';
import 'package:arthor/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenNewcasespage extends StatefulWidget {
  const ScreenNewcasespage({super.key});

  @override
  State<ScreenNewcasespage> createState() => _ScreenNewcasespageState();
}

class _ScreenNewcasespageState extends State<ScreenNewcasespage> {
  String? expandedCaseId;

  @override
  void initState() {
    super.initState();
    // Trigger the fetch event when the page loads
    context.read<FetchNewcasesBloc>().add(FetchNecasesInitialEvent());
  }

  String formatDate(String dateString) {
    if (dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  String formatTime(String dateString) {
    if (dateString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "New Cases"),
      body: BlocBuilder<FetchNewcasesBloc, FetchNewcasesState>(
        builder: (context, state) {
          // Loading State
          if (state is FetchNewCasesLoadingState) {
            return const CaseCardsShimmerLoading(count: 3);
          }

          // Error State
          if (state is FetchNewCasesErroStatae) {
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
                      context.read<FetchNewcasesBloc>().add(
                        FetchNecasesInitialEvent(),
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

          // Success State
          if (state is FetchNewCasesSuccessState) {
            final cases = state.newcases;

            // Empty State
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
                context.read<FetchNewcasesBloc>().add(
                  FetchNecasesInitialEvent(),
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
                     final addressInfo = _getAvailableAddress(caseItem);
                     final topPincode = _getAvailablePincode(caseItem);

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
                              // Header Row - Date, Time & Action Buttons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Date & Time
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: ResponsiveUtils.sp(3.5),
                                        color: Appcolors.ksecondarycolor,
                                      ),
                                      SizedBox(width: ResponsiveUtils.wp(2)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextStyles.caption(
                                            text: formatDate(
                                              caseItem.createdAt.date,
                                            ),
                                            weight: FontWeight.w600,
                                            color: Appcolors.kblackcolor,
                                          ),
                                          TextStyles.caption(
                                            text: formatTime(
                                              caseItem.createdAt.date,
                                            ),
                                            color: Colors.grey[600],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Quick Action Buttons (only when not expanded)
                                  if (!isExpanded)
                                    BlocConsumer<
                                      CaseAcceptDeclineBloc,
                                      CaseAcceptDeclineState
                                    >(
                                      listener: (context, state) {
                                        if (state
                                            is CaseAcceptdeclineSucessState) {
                                          CustomSnackbar.show(
                                            context,
                                            message: state.message,
                                            type: SnackbarType.success,
                                          );
                                          context.read<FetchNewcasesBloc>().add(
                                            FetchNecasesInitialEvent(),
                                          );
                                        } else if (state
                                            is CaseAcceptancedeclineErrorState) {
                                          CustomSnackbar.show(
                                            context,
                                            message: state.message,
                                            type: SnackbarType.success,
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        bool isAcceptLoading = false;
                                        bool isRejectLoading = false;

                                        if (state
                                            is CaseAcceptdeclineLoadingState) {
                                          if (state.isAccepting) {
                                            isAcceptLoading = true;
                                          } else {
                                            isRejectLoading = true;
                                          }
                                        }

                                        return Row(
                                          children: [
                                            // ✅ ACCEPT BUTTON
                                            IconButton(
                                              onPressed:
                                                  (isAcceptLoading ||
                                                      isRejectLoading)
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<
                                                            CaseAcceptDeclineBloc
                                                          >()
                                                          .add(
                                                            CaseAcceptButtonClickEvent(
                                                              caseId: caseItem
                                                                  .caseId,
                                                            ),
                                                          );
                                                      setState(() {
                                                        expandedCaseId = null;
                                                      });
                                                    },
                                              icon: isAcceptLoading
                                                  ? const SizedBox(
                                                      width: 22,
                                                      height: 22,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                    ),
                                              color: Colors.green,
                                              iconSize: ResponsiveUtils.sp(7),
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),

                                            SizedBox(
                                              width: ResponsiveUtils.wp(2),
                                            ),

                                            // ❌ DECLINE BUTTON
                                            IconButton(
                                              onPressed:
                                                  (isAcceptLoading ||
                                                      isRejectLoading)
                                                  ? null
                                                  : () {
                                                      context
                                                          .read<
                                                            CaseAcceptDeclineBloc
                                                          >()
                                                          .add(
                                                            CaseDeclineButtonClickEvent(
                                                              caseId: caseItem
                                                                  .caseId,
                                                            ),
                                                          );
                                                      setState(() {
                                                        expandedCaseId = null;
                                                      });
                                                    },
                                              icon: isRejectLoading
                                                  ? const SizedBox(
                                                      width: 22,
                                                      height: 22,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                          ),
                                                    )
                                                  : const Icon(
                                                      Icons.cancel_outlined,
                                                    ),
                                              color: Colors.red,
                                              iconSize: ResponsiveUtils.sp(7),
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

            
                                ],
                              ),

                              ResponsiveSizedBox.height10,

                              // Name
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextStyles.subheadline(
                                      text: caseItem.customerName,
                                      weight: FontWeight.bold,
                                      color: Appcolors.kblackcolor,
                                    ),
                                  ),
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
                                ],
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
                              ResponsiveSizedBox.height5,
                              // Product Type & Pin Code Row
                          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: ResponsiveUtils.sp(3.5),
            color: Appcolors.ksecondarycolor,
          ),
          SizedBox(width: ResponsiveUtils.wp(1)),
          TextStyles.body(
            text: topPincode,
            weight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ],
      ),
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
                                  value: caseItem.clientName,
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
  onTap: () => _callPhoneNumber(caseItem.customerPhoneNumber),
),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.phone_outlined,
                                  label: "Alternative Mobile Number",
                                  value: caseItem.alternatePhoneNumber,
                                    onTap: () => _callPhoneNumber(caseItem.alternatePhoneNumber),
                                ),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.domain_verification,
                                  label: "Verification Type",
                                  value: caseItem.customerType,
                                ),
                                ResponsiveSizedBox.height10,
                                _buildDetailRow(
                                  icon: Icons.location_city_outlined,
                                  label: "Location",
                                  value: caseItem.city,
                                ),
                                ResponsiveSizedBox.height10,
                             
   _buildDetailRow(
  icon: Icons.location_on_outlined,
  label: addressInfo['label'] ?? 'Address',
  value: addressInfo['value'] ?? '',
),

                                ResponsiveSizedBox.height20,

                                // Action Buttons
                                BlocConsumer<CaseAcceptDeclineBloc, CaseAcceptDeclineState>(
  listener: (context, state) {
    if (state is CaseAcceptdeclineSucessState) {
      CustomSnackbar.show(
        context,
        message: state.message,
        type: SnackbarType.success,
      );
      context.read<FetchNewcasesBloc>().add(
            FetchNecasesInitialEvent(),
          );
    } else if (state is CaseAcceptancedeclineErrorState) {
      CustomSnackbar.show(
        context,
        message: state.message,
        type: SnackbarType.success, // ← keep as you wrote
      );
    }
  },
  builder: (context, state) {
    bool isAcceptLoading = false;
    bool isRejectLoading = false;

    if (state is CaseAcceptdeclineLoadingState) {
      if (state.isAccepting) {
        isAcceptLoading = true;
      } else {
        isRejectLoading = true;
      }
    }

    return Row(
      children: [
        // ✅ ACCEPT BUTTON (same UI, uses bloc)
        Expanded(
          child: ElevatedButton.icon(
            onPressed: (isAcceptLoading || isRejectLoading)
                ? null
                : () {
                    context
                        .read<CaseAcceptDeclineBloc>()
                        .add(
                          CaseAcceptButtonClickEvent(
                            caseId: caseItem.caseId,
                          ),
                        );
                    setState(() {
                      expandedCaseId = null;
                    });
                  },
            icon: isAcceptLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.check_circle),
            label: TextStyles.body(
              text: "Accept",
              weight: FontWeight.w600,
              color: Appcolors.kwhitecolor,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Appcolors.kwhitecolor,
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.hp(1.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              elevation: 0,
            ),
          ),
        ),

        SizedBox(width: ResponsiveUtils.wp(3)),

        // ❌ REJECT BUTTON (same UI, uses bloc)
        Expanded(
          child: ElevatedButton.icon(
            onPressed: (isAcceptLoading || isRejectLoading)
                ? null
                : () {
                    context
                        .read<CaseAcceptDeclineBloc>()
                        .add(
                          CaseDeclineButtonClickEvent(
                            caseId: caseItem.caseId,
                          ),
                        );
                    setState(() {
                      expandedCaseId = null;
                    });
                  },
            icon: isRejectLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.cancel),
            label: TextStyles.body(
              text: "Reject",
              weight: FontWeight.w600,
              color: Appcolors.kwhitecolor,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Appcolors.kwhitecolor,
              padding: EdgeInsets.symmetric(
                vertical: ResponsiveUtils.hp(1.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  },
)

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
          }

          // Initial/Default State
          return Center(
            child: CircularProgressIndicator(color: Appcolors.kprimarycolor),
          );
        },
      ),
    );
  }

Widget _buildDetailRow({
  required IconData icon,
  required String label,
  required String value,
  VoidCallback? onTap, // 👈 new optional callback
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(3.5),
                  fontWeight: FontWeight.w600,
                  color: Appcolors.kblackcolor,
                  decoration: onTap != null
                      ? TextDecoration.underline
                      : TextDecoration.none, // optional underline
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void _callPhoneNumber(String number) async {
  final Uri uri = Uri(scheme: 'tel', path: number);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    debugPrint("Could not launch dialer");
  }
}

  // Pick which PINCODE to show on top row
String _getAvailablePincode(dynamic caseItem) {
  final presentPin = caseItem.presentAddressPincode ?? '';
  final businessPin = caseItem.businessAddressPincode ?? '';
  final permanentPin = caseItem.permanentAddressPincode ?? '';

  if (presentPin.isNotEmpty) return presentPin;
  if (businessPin.isNotEmpty) return businessPin;
  if (permanentPin.isNotEmpty) return permanentPin;

  return '-';
}

// Pick which ADDRESS to show in expanded view
Map<String, String> _getAvailableAddress(dynamic caseItem) {
  final present = caseItem.presentAddress ?? '';
  final business = caseItem.businessAddress ?? '';
  final permanent = caseItem.permanentAddress ?? '';

  if (present.isNotEmpty) {
    return {'label': 'Present Address', 'value': present};
  }
  if (business.isNotEmpty) {
    return {'label': 'Business Address', 'value': business};
  }
  if (permanent.isNotEmpty) {
    return {'label': 'Permanent Address', 'value': permanent};
  }

  return {'label': 'Address', 'value': 'N/A'};
}

}
