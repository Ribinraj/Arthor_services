class CaseDataModel {
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
  final String landmark;
  final String floor;
  final String leadExecutiveId;
  final String executiveId;
  final String caseRemarks;
  final String addressStatus;
  final String reasonId;
  final String entryAllowed;
  final String maritalStatus;
  final String permanentAddressOccupiedBy;
  final String applicantStayingPlace;
  final String metPerson;
  final String relationshipWithApplicant;
  final String applicantAge;
  final String rentStatus;
  final String rentLeaseAmount;
  final String yearsOfStaying;
  final String totalFamilyMembers;
  final String noOfEarners;
  final String earners;
  final String noOfDependents;
  final String salaryStatus;
  final String companyName;
  final String designation;
  final String salary;
  final String monthlyIncome;
  final String roofType;
  final String houseType;
  final String businessType;
  final String sqft;
  final String typeOfArea;
  final String neighborName;
  final String additionalNeighborName;
  final String km;
  final String metPersonDesignation;
  final String yearsOfWorking;
  final String nameBoardDisplayed;
  final String natureOfBusiness;
  final String numberOfPeopleWorking;
  final String latt;
  final String longitude; // mapped from "long"
  final String status;
  final String caseResult;
  final String notes;
  final String summaryType;
  final String maskPhoneNo;
  final String attachment;
  final String acceptedAt;
  final DateTimeInfo createdAt;
  final DateTimeInfo updatedAt;
  final String completedAt;
  final String clientName;
  final String branchName;
  final String productName;
  final String subProductName;
  final String customerType;
  final String verificationTypeName;

  CaseDataModel({
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
    required this.landmark,
    required this.floor,
    required this.leadExecutiveId,
    required this.executiveId,
    required this.caseRemarks,
    required this.addressStatus,
    required this.reasonId,
    required this.entryAllowed,
    required this.maritalStatus,
    required this.permanentAddressOccupiedBy,
    required this.applicantStayingPlace,
    required this.metPerson,
    required this.relationshipWithApplicant,
    required this.applicantAge,
    required this.rentStatus,
    required this.rentLeaseAmount,
    required this.yearsOfStaying,
    required this.totalFamilyMembers,
    required this.noOfEarners,
    required this.earners,
    required this.noOfDependents,
    required this.salaryStatus,
    required this.companyName,
    required this.designation,
    required this.salary,
    required this.monthlyIncome,
    required this.roofType,
    required this.houseType,
    required this.businessType,
    required this.sqft,
    required this.typeOfArea,
    required this.neighborName,
    required this.additionalNeighborName,
    required this.km,
    required this.metPersonDesignation,
    required this.yearsOfWorking,
    required this.nameBoardDisplayed,
    required this.natureOfBusiness,
    required this.numberOfPeopleWorking,
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
    required this.branchName,
    required this.productName,
    required this.subProductName,
    required this.customerType,
    required this.verificationTypeName,
  });

  factory CaseDataModel.fromJson(Map<String, dynamic> json) {
    return CaseDataModel(
      caseId: json['caseId'] ?? '',
      clientId: json['clientId'] ?? '',
      branchId: json['branchId'] ?? '',
      productId: json['productId'] ?? '',
      referenceId: json['referenceId'] ?? '',
      referenceId1: json['referenceId_1'] ?? '',
      referenceId2: json['referenceId_2'] ?? '',
      customerName: json['customerName'] ?? '',
      customerTypeId: json['customerTypeId'] ?? '',
      verificationTypeId: json['verificationTypeId'] ?? '',
      customerPhoneNumber: json['customerPhoneNumber'] ?? '',
      alternatePhoneNumber: json['alternatePhoneNumber'] ?? '',
      presentAddress: json['presentAddress'] ?? '',
      presentAddressPincode: json['presentAddressPincode'] ?? '',
      businessAddress: json['businessAddress'] ?? '',
      businessAddressPincode: json['businessAddressPincode'] ?? '',
      permanentAddress: json['permanentAddress'] ?? '',
      permanentAddressPincode: json['permanentAddressPincode'] ?? '',
      city: json['city'] ?? '',
      landmark: json['landmark'] ?? '',
      floor: json['floor'] ?? '',
      leadExecutiveId: json['leadExecutiveId'] ?? '',
      executiveId: json['executiveId'] ?? '',
      caseRemarks: json['caseRemarks'] ?? '',
      addressStatus: json['addressStatus'] ?? '',
      reasonId: json['reasonId'] ?? '',
      entryAllowed: json['entryAllowed'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      permanentAddressOccupiedBy:
          json['permanentAddressOccupiedBy'] ?? '',
      applicantStayingPlace: json['applicantStayingPlace'] ?? '',
      metPerson: json['metPerson'] ?? '',
      relationshipWithApplicant:
          json['relationshipWithApplicant'] ?? '',
      applicantAge: json['applicantAge'] ?? '',
      rentStatus: json['rentStatus'] ?? '',
      rentLeaseAmount: json['rentLeaseAmount'] ?? '',
      yearsOfStaying: json['yearsOfStaying'] ?? '',
      totalFamilyMembers: json['totalFamilyMembers'] ?? '',
      noOfEarners: json['noOfEarners'] ?? '',
      earners: json['earners'] ?? '',
      noOfDependents: json['noOfDependents'] ?? '',
      salaryStatus: json['salaryStatus'] ?? '',
      companyName: json['companyName'] ?? '',
      designation: json['designation'] ?? '',
      salary: json['salary'] ?? '',
      monthlyIncome: json['monthlyIncome'] ?? '',
      roofType: json['roofType'] ?? '',
      houseType: json['houseType'] ?? '',
      businessType: json['businessType'] ?? '',
      sqft: json['sqft'] ?? '',
      typeOfArea: json['typeOfArea'] ?? '',
      neighborName: json['neighborName'] ?? '',
      additionalNeighborName:
          json['additionalNeighborName'] ?? '',
      km: json['km'] ?? '',
      metPersonDesignation:
          json['metPersonDesignation'] ?? '',
      yearsOfWorking: json['yearsOfWorking'] ?? '',
      nameBoardDisplayed: json['nameBoardDisplayed'] ?? '',
      natureOfBusiness: json['natureOfBusiness'] ?? '',
      numberOfPeopleWorking:
          json['numberOfPeopleWorking'] ?? '',
      latt: json['latt'] ?? '',
      longitude: json['long'] ?? '',
      status: json['status'] ?? '',
      caseResult: json['caseResult'] ?? '',
      notes: json['notes'] ?? '',
      summaryType: json['summaryType'] ?? '',
      maskPhoneNo: json['maskPhoneNo'] ?? '',
      attachment: json['attachment'] ?? '',
      acceptedAt: json['accepted_at'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTimeInfo.fromJson(json['created_at'])
          : DateTimeInfo.empty(),
      updatedAt: json['updated_at'] != null
          ? DateTimeInfo.fromJson(json['updated_at'])
          : DateTimeInfo.empty(),
      completedAt: json['completed_at'] ?? '',
      clientName: json['clientName'] ?? '',
      branchName: json['branchName'] ?? '',
      productName: json['productName'] ?? '',
      subProductName: json['subProductName'] ?? '',
      customerType: json['customerType'] ?? '',
      verificationTypeName:
          json['verificationTypeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'caseId': caseId,
        'clientId': clientId,
        'branchId': branchId,
        'productId': productId,
        'referenceId': referenceId,
        'referenceId_1': referenceId1,
        'referenceId_2': referenceId2,
        'customerName': customerName,
        'customerTypeId': customerTypeId,
        'verificationTypeId': verificationTypeId,
        'customerPhoneNumber': customerPhoneNumber,
        'alternatePhoneNumber': alternatePhoneNumber,
        'presentAddress': presentAddress,
        'presentAddressPincode': presentAddressPincode,
        'businessAddress': businessAddress,
        'businessAddressPincode': businessAddressPincode,
        'permanentAddress': permanentAddress,
        'permanentAddressPincode': permanentAddressPincode,
        'city': city,
        'landmark': landmark,
        'floor': floor,
        'leadExecutiveId': leadExecutiveId,
        'executiveId': executiveId,
        'caseRemarks': caseRemarks,
        'addressStatus': addressStatus,
        'reasonId': reasonId,
        'entryAllowed': entryAllowed,
        'maritalStatus': maritalStatus,
        'permanentAddressOccupiedBy': permanentAddressOccupiedBy,
        'applicantStayingPlace': applicantStayingPlace,
        'metPerson': metPerson,
        'relationshipWithApplicant': relationshipWithApplicant,
        'applicantAge': applicantAge,
        'rentStatus': rentStatus,
        'rentLeaseAmount': rentLeaseAmount,
        'yearsOfStaying': yearsOfStaying,
        'totalFamilyMembers': totalFamilyMembers,
        'noOfEarners': noOfEarners,
        'earners': earners,
        'noOfDependents': noOfDependents,
        'salaryStatus': salaryStatus,
        'companyName': companyName,
        'designation': designation,
        'salary': salary,
        'monthlyIncome': monthlyIncome,
        'roofType': roofType,
        'houseType': houseType,
        'businessType': businessType,
        'sqft': sqft,
        'typeOfArea': typeOfArea,
        'neighborName': neighborName,
        'additionalNeighborName': additionalNeighborName,
        'km': km,
        'metPersonDesignation': metPersonDesignation,
        'yearsOfWorking': yearsOfWorking,
        'nameBoardDisplayed': nameBoardDisplayed,
        'natureOfBusiness': natureOfBusiness,
        'numberOfPeopleWorking': numberOfPeopleWorking,
        'latt': latt,
        'long': longitude,
        'status': status,
        'caseResult': caseResult,
        'notes': notes,
        'summaryType': summaryType,
        'maskPhoneNo': maskPhoneNo,
        'attachment': attachment,
        'accepted_at': acceptedAt,
        'created_at': createdAt.toJson(),
        'updated_at': updatedAt.toJson(),
        'completed_at': completedAt,
        'clientName': clientName,
        'branchName': branchName,
        'productName': productName,
        'subProductName': subProductName,
        'customerType': customerType,
        'verificationTypeName': verificationTypeName,
      };
}

class DateTimeInfo {
  final String date;
  final int timezoneType;
  final String timezone;

  DateTimeInfo({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory DateTimeInfo.fromJson(Map<String, dynamic> json) {
    return DateTimeInfo(
      date: json['date'] ?? '',
      timezoneType: (json['timezone_type'] ?? 0) is int
          ? json['timezone_type'] ?? 0
          : int.tryParse(json['timezone_type']?.toString() ?? '0') ?? 0,
      timezone: json['timezone'] ?? '',
    );
  }

  factory DateTimeInfo.empty() =>
      DateTimeInfo(date: '', timezoneType: 0, timezone: '');

  Map<String, dynamic> toJson() => {
        'date': date,
        'timezone_type': timezoneType,
        'timezone': timezone,
      };
}