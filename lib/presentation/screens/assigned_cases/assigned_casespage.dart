import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/data/teamcases_model.dart';
import 'package:arthor/presentation/blocs/fetch_teamcases_bloc/fetch_teamcases_bloc.dart';
import 'package:arthor/presentation/screens/screen_newcasespage/widgets/loading_shimmerwidget.dart';
import 'package:arthor/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAssignedCasespage extends StatefulWidget {
  const ScreenAssignedCasespage({super.key});

  @override
  State<ScreenAssignedCasespage> createState() =>
      _ScreenAssignedCasespageState();
}

class _ScreenAssignedCasespageState extends State<ScreenAssignedCasespage> {
  String? expandedCaseId;

  @override
  void initState() {
    super.initState();
    context.read<FetchTeamcasesBloc>().add(FetchTeamcasesInitialEvent());
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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Appcolors.kprimarycolor;
      case 'in progress':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      default:
        return Appcolors.kprimarycolor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "Assign Cases"),
      body: BlocBuilder<FetchTeamcasesBloc, FetchTeamcasesState>(
        builder: (context, state) {
          if (state is FetchTeamcasesLoadingState) {
            return const CaseCardsShimmerLoading(count: 3);
          }

          if (state is FetchTeamcasesErrorState) {
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
                      context.read<FetchTeamcasesBloc>().add(
                        FetchTeamcasesInitialEvent(),
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

          if (state is FetchTeamcasesSuccessState) {
            final teamCases = state.teamCases;

            if (teamCases.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FetchTeamcasesBloc>().add(
                    FetchTeamcasesInitialEvent(),
                  );
                },
                color: Appcolors.kprimarycolor,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: ResponsiveUtils.hp(25)),
                    Icon(
                      Icons.assignment_outlined,
                      size: ResponsiveUtils.sp(15),
                      color: Colors.grey,
                    ),
                    ResponsiveSizedBox.height20,
                    Center(
                      child: TextStyles.subheadline(
                        text: "No assigned cases available",
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FetchTeamcasesBloc>().add(
                  FetchTeamcasesInitialEvent(),
                );
              },
              color: Appcolors.kprimarycolor,
              child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(4),
                vertical: ResponsiveUtils.hp(2),
              ),
              itemCount: teamCases.length,
              itemBuilder: (context, index) {
                final caseItem = teamCases[index];
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
                          expandedCaseId = isExpanded ? null : caseItem.caseId;
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.wp(3),
                                    vertical: ResponsiveUtils.hp(0.8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor(
                                      caseItem.status,
                                    ).withOpacity(0.12),
                                    borderRadius:
                                        BorderRadiusStyles.kradius20(),
                                  ),
                                  child: TextStyles.caption(
                                    text: caseItem.status,
                                    weight: FontWeight.bold,
                                    color: _statusColor(caseItem.status),
                                  ),
                                ),
                              ],
                            ),
                            ResponsiveSizedBox.height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextStyles.subheadline(
                                    text: caseItem.customerName,
                                    weight: FontWeight.bold,
                                    color: Appcolors.kblackcolor,
                                  ),
                                ),
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
                                  padding: const EdgeInsets.symmetric(
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
                                onTap: () => _callPhoneNumber(
                                  caseItem.customerPhoneNumber,
                                ),
                              ),
                              ResponsiveSizedBox.height10,
                              _buildDetailRow(
                                icon: Icons.phone_outlined,
                                label: "Alternative Mobile Number",
                                value: caseItem.alternatePhoneNumber,
                                onTap: () => _callPhoneNumber(
                                  caseItem.alternatePhoneNumber,
                                ),
                              ),
                              ResponsiveSizedBox.height10,
                              _buildDetailRow(
                                icon: Icons.domain_verification,
                                label: "Verification Type",
                                value: caseItem.verificationTypeName,
                              ),
                              ResponsiveSizedBox.height10,
                              _buildDetailRow(
                                icon: Icons.location_city_outlined,
                                label: "Location",
                                value: caseItem.city,
                              ),
                              ResponsiveSizedBox.height10,
                              _buildDetailRow(
                                icon: Icons.assignment_ind_outlined,
                                label: "Assigned To",
                                value: caseItem.executiveName.isNotEmpty
                                    ? caseItem.executiveName
                                    : 'NA',
                              ),
                              ResponsiveSizedBox.height10,
                              _buildDetailRow(
                                icon: Icons.location_on_outlined,
                                label: addressInfo['label'] ?? 'Address',
                                value: addressInfo['value'] ?? '',
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
          }

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
    VoidCallback? onTap,
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
                        : TextDecoration.none,
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

  String _getAvailablePincode(TeamCaseModel caseItem) {
    if (caseItem.presentAddressPincode.isNotEmpty) {
      return caseItem.presentAddressPincode;
    }
    if (caseItem.businessAddressPincode.isNotEmpty) {
      return caseItem.businessAddressPincode;
    }
    if (caseItem.permanentAddressPincode.isNotEmpty) {
      return caseItem.permanentAddressPincode;
    }
    return '-';
  }

  Map<String, String> _getAvailableAddress(TeamCaseModel caseItem) {
    if (caseItem.presentAddress.isNotEmpty) {
      return {'label': 'Present Address', 'value': caseItem.presentAddress};
    }
    if (caseItem.businessAddress.isNotEmpty) {
      return {'label': 'Business Address', 'value': caseItem.businessAddress};
    }
    if (caseItem.permanentAddress.isNotEmpty) {
      return {
        'label': 'Permanent Address',
        'value': caseItem.permanentAddress,
      };
    }

    return {'label': 'Address', 'value': 'N/A'};
  }
}
