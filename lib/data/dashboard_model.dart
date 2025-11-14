class DashboardModel {
  final String? executiveId;
  final String? executiveName;
  final String? executiveCode;
  final String? executiveMobile;
  final String? executiveStatus;
  final String? executiveOTP;
  final String? reportTo;
  final String? pushToken;
  final DateTime? createdAt;
  final String? modifiedAt;
  final Dashboard? dashboard;

  DashboardModel({
    this.executiveId,
    this.executiveName,
    this.executiveCode,
    this.executiveMobile,
    this.executiveStatus,
    this.executiveOTP,
    this.reportTo,
    this.pushToken,
    this.createdAt,
    this.modifiedAt,
    this.dashboard,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      executiveId: json['executiveId']?.toString(),
      executiveName: json['executiveName'],
      executiveCode: json['executiveCode'],
      executiveMobile: json['executiveMobile'],
      executiveStatus: json['executiveStatus'],
      executiveOTP: json['executiveOTP'],
      reportTo: json['reportTo']?.toString(),
      pushToken: json['pushToken'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']['date'] ?? '')
          : null,
      modifiedAt: json['modified_at']?.toString(),
      dashboard: json['dashboard'] != null
          ? Dashboard.fromJson(json['dashboard'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "executiveId": executiveId,
      "executiveName": executiveName,
      "executiveCode": executiveCode,
      "executiveMobile": executiveMobile,
      "executiveStatus": executiveStatus,
      "executiveOTP": executiveOTP,
      "reportTo": reportTo,
      "pushToken": pushToken,
      "created_at": createdAt?.toIso8601String(),
      "modified_at": modifiedAt,
      "dashboard": dashboard?.toJson(),
    };
  }
}
class Dashboard {
  final String? newCases;
  final String? assignedCases;
  final String? completedCases;

  Dashboard({
    this.newCases,
    this.assignedCases,
    this.completedCases,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      newCases: json['newCases']?.toString(),
      assignedCases: json['assignedCases']?.toString(),
      completedCases: json['completedCases']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "newCases": newCases,
      "assignedCases": assignedCases,
      "completedCases": completedCases,
    };
  }
}
