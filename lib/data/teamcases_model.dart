class TeamCaseModel {
  final String caseId;
  final String clientId;
  final String branchId;
  final String productId;
  final String referenceId;
  final String referenceId1;
  final String referenceId2;
  final String customerName;
  final String customerTypeId;
  final String verificationTypeId;
  final String customerPhoneNumber;
  final String alternatePhoneNumber;
  final String presentAddress;
  final String presentAddressPincode;
  final String businessAddress;
  final String businessAddressPincode;
  final String permanentAddress;
  final String permanentAddressPincode;
  final String city;
  final String leadExecutiveId;
  final String executiveId;
  final String caseRemarks;
  final String addressStatus;
  final String reasonId;
  final String latt;
  final String longitude;
  final String status;
  final String caseResult;
  final String notes;
  final String summaryType;
  final String maskPhoneNo;
  final String attachment;
  final String acceptedAt;
  final TeamCaseDateTimeInfo createdAt;
  final TeamCaseDateTimeInfo updatedAt;
  final String completedAt;
  final String clientName;
  final String executiveName;
  final String branchName;
  final String productName;
  final String subProductName;
  final String customerType;
  final String verificationTypeName;

  const TeamCaseModel({
    required this.caseId,
    required this.clientId,
    required this.branchId,
    required this.productId,
    required this.referenceId,
    required this.referenceId1,
    required this.referenceId2,
    required this.customerName,
    required this.customerTypeId,
    required this.verificationTypeId,
    required this.customerPhoneNumber,
    required this.alternatePhoneNumber,
    required this.presentAddress,
    required this.presentAddressPincode,
    required this.businessAddress,
    required this.businessAddressPincode,
    required this.permanentAddress,
    required this.permanentAddressPincode,
    required this.city,
    required this.leadExecutiveId,
    required this.executiveId,
    required this.caseRemarks,
    required this.addressStatus,
    required this.reasonId,
    required this.latt,
    required this.longitude,
    required this.status,
    required this.caseResult,
    required this.notes,
    required this.summaryType,
    required this.maskPhoneNo,
    required this.attachment,
    required this.acceptedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.completedAt,
    required this.clientName,
    required this.executiveName,
    required this.branchName,
    required this.productName,
    required this.subProductName,
    required this.customerType,
    required this.verificationTypeName,
  });

  factory TeamCaseModel.fromJson(Map<String, dynamic> json) {
    return TeamCaseModel(
      caseId: json['caseId']?.toString() ?? '',
      clientId: json['clientId']?.toString() ?? '',
      branchId: json['branchId']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      referenceId: json['referenceId']?.toString() ?? '',
      referenceId1: json['referenceId_1']?.toString() ?? '',
      referenceId2: json['referenceId_2']?.toString() ?? '',
      customerName: json['customerName']?.toString() ?? '',
      customerTypeId: json['customerTypeId']?.toString() ?? '',
      verificationTypeId: json['verificationTypeId']?.toString() ?? '',
      customerPhoneNumber: json['customerPhoneNumber']?.toString() ?? '',
      alternatePhoneNumber: json['alternatePhoneNumber']?.toString() ?? '',
      presentAddress: json['presentAddress']?.toString() ?? '',
      presentAddressPincode: json['presentAddressPincode']?.toString() ?? '',
      businessAddress: json['businessAddress']?.toString() ?? '',
      businessAddressPincode: json['businessAddressPincode']?.toString() ?? '',
      permanentAddress: json['permanentAddress']?.toString() ?? '',
      permanentAddressPincode:
          json['permanentAddressPincode']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      leadExecutiveId: json['leadExecutiveId']?.toString() ?? '',
      executiveId: json['executiveId']?.toString() ?? '',
      caseRemarks: json['caseRemarks']?.toString() ?? '',
      addressStatus: json['addressStatus']?.toString() ?? '',
      reasonId: json['reasonId']?.toString() ?? '',
      latt: json['latt']?.toString() ?? '',
      longitude: json['long']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      caseResult: json['caseResult']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      summaryType: json['summaryType']?.toString() ?? '',
      maskPhoneNo: json['maskPhoneNo']?.toString() ?? '',
      attachment: json['attachment']?.toString() ?? '',
      acceptedAt: json['accepted_at']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? TeamCaseDateTimeInfo.fromJson(json['created_at'])
          : TeamCaseDateTimeInfo.empty(),
      updatedAt: json['updated_at'] != null
          ? TeamCaseDateTimeInfo.fromJson(json['updated_at'])
          : TeamCaseDateTimeInfo.empty(),
      completedAt: json['completed_at']?.toString() ?? '',
      clientName: json['clientName']?.toString() ?? '',
      executiveName: json['executiveName']?.toString() ?? '',
      branchName: json['branchName']?.toString() ?? '',
      productName: json['productName']?.toString() ?? '',
      subProductName: json['subProductName']?.toString() ?? '',
      customerType: json['customerType']?.toString() ?? '',
      verificationTypeName: json['verificationTypeName']?.toString() ?? '',
    );
  }
}

class TeamCaseDateTimeInfo {
  final String date;
  final int timezoneType;
  final String timezone;

  const TeamCaseDateTimeInfo({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory TeamCaseDateTimeInfo.fromJson(Map<String, dynamic> json) {
    return TeamCaseDateTimeInfo(
      date: json['date']?.toString() ?? '',
      timezoneType: (json['timezone_type'] ?? 0) is int
          ? json['timezone_type'] ?? 0
          : int.tryParse(json['timezone_type']?.toString() ?? '0') ?? 0,
      timezone: json['timezone']?.toString() ?? '',
    );
  }

  factory TeamCaseDateTimeInfo.empty() =>
      const TeamCaseDateTimeInfo(date: '', timezoneType: 0, timezone: '');
}
