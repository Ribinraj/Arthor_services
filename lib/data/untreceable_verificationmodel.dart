class UntreceableVerificationmodel {
  final String caseId;
  final String addressStatus;
  final String reasonId;
  final String caseResult;
  final List<Attachment> attachments;

  UntreceableVerificationmodel({
    required this.caseId,
    required this.addressStatus,
    required this.reasonId,
    required this.caseResult,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      "caseId": caseId,
      "addressStatus": addressStatus,
      "reasonId": reasonId,
      "caseResult": caseResult,
      "attachments": attachments.map((e) => e.toJson()).toList(),
    };
  }

  factory UntreceableVerificationmodel.fromJson(Map<String, dynamic> json) {
    return UntreceableVerificationmodel(
      caseId: json["caseId"],
      addressStatus: json["addressStatus"],
      reasonId: json["reasonId"],
      caseResult: json["caseResult"],
      attachments: (json["attachments"] as List)
          .map((e) => Attachment.fromJson(e))
          .toList(),
    );
  }
}

class Attachment {
  final String latitude;
  final String longitude;
  final String dateTime;
  final String fileName;
  final String file;
  final String address; // NEW

  Attachment({
    required this.latitude,
    required this.longitude,
    required this.dateTime,
    required this.fileName,
    required this.file,
    required this.address, // NEW
  });

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "dateTime": dateTime,
      "fileName": fileName,
      "file": file,
      "address": address, // NEW
    };
  }

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      latitude: json["latitude"],
      longitude: json["longitude"],
      dateTime: json["dateTime"],
      fileName: json["fileName"],
      file: json["file"],
      address: json["address"], // NEW
    );
  }
}
