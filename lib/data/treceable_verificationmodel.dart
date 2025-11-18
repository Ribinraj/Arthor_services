// class TreceableVerificationmodel {
//   final String caseId;
//   final String addressStatus;
//   final String caseResult;
//   final String latt;
//   final String longi;
//   final SingleAttachment? attachment;
//   final List<Attachment> attachments;
//   final List<AttributeItem> attributes;

//   TreceableVerificationmodel({
//     required this.caseId,
//     required this.addressStatus,
//     required this.caseResult,
//     required this.latt,
//     required this.longi,
//     this.attachment,
//     required this.attachments,
//     required this.attributes,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "caseId": caseId,
//       "addressStatus": addressStatus,
//       "caseResult": caseResult,
//       "latt": latt,
//       "long": longi,
//       "attachment": attachment?.toJson(),
//       "attachments": attachments.map((e) => e.toJson()).toList(),
//       "attributes": attributes.map((e) => e.toJson()).toList(),
//     };
//   }

//   factory TreceableVerificationmodel.fromJson(Map<String, dynamic> json) {
//     return TreceableVerificationmodel(
//       caseId: json["caseId"],
//       addressStatus: json["addressStatus"],
//       caseResult: json["caseResult"],
//       latt: json["latt"],
//       longi: json["long"],
//       attachment: json["attachment"] != null
//           ? SingleAttachment.fromJson(json["attachment"])
//           : null,
//       attachments: (json["attachments"] as List)
//           .map((e) => Attachment.fromJson(e))
//           .toList(),
//       attributes: (json["attributes"] as List)
//           .map((e) => AttributeItem.fromJson(e))
//           .toList(),
//     );
//   }
// }

// class SingleAttachment {
//   final String fileName;
//   final String file;

//   SingleAttachment({
//     required this.fileName,
//     required this.file,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "fileName": fileName,
//       "file": file,
//     };
//   }

//   factory SingleAttachment.fromJson(Map<String, dynamic> json) {
//     return SingleAttachment(
//       fileName: json["fileName"],
//       file: json["file"],
//     );
//   }
// }

// class Attachment {
//   final String fileName;
//   final String file;
//   final String latt;
//   final String longi;
//   final String address;

//   Attachment({
//     required this.fileName,
//     required this.file,
//     required this.latt,
//     required this.longi,
//     required this.address,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "fileName": fileName,
//       "file": file,
//       "latt": latt,
//       "long": longi,
//       "address": address,
//     };
//   }

//   factory Attachment.fromJson(Map<String, dynamic> json) {
//     return Attachment(
//       fileName: json["fileName"],
//       file: json["file"],
//       latt: json["latt"],
//       longi: json["long"],
//       address: json["address"],
//     );
//   }
// }

// class AttributeItem {
//   final int attributeId;
//   final String value;

//   AttributeItem({
//     required this.attributeId,
//     required this.value,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "attributeId": attributeId,
//       "value": value,
//     };
//   }

//   factory AttributeItem.fromJson(Map<String, dynamic> json) {
//     return AttributeItem(
//       attributeId: json["attributeId"],
//       value: json["value"],
//     );
//   }
// }
class TreceableVerificationmodel {
  final String caseId;
  final String addressStatus;
  final String caseResult;
  final String latt;
  final String longi;
  final SingleAttachment? attachment;
  final List<Attachment> attachments;
  final List<AttributeItem> attributes;

  TreceableVerificationmodel({
    required this.caseId,
    required this.addressStatus,
    required this.caseResult,
    required this.latt,
    required this.longi,
    this.attachment,
    required this.attachments,
    required this.attributes,
  });

  Map<String, dynamic> toJson() {
    return {
      "caseId": caseId,
      "addressStatus": addressStatus,
      "caseResult": caseResult,
      "latt": latt,
      "long": longi,
      "attachment": attachment?.toJson(),
      "attachments": attachments.map((e) => e.toJson()).toList(),
      "attributes": attributes.map((e) => e.toJson()).toList(),
    };
  }

  factory TreceableVerificationmodel.fromJson(Map<String, dynamic> json) {
    return TreceableVerificationmodel(
      caseId: json["caseId"],
      addressStatus: json["addressStatus"],
      caseResult: json["caseResult"],
      latt: json["latt"],
      longi: json["long"],
      attachment: json["attachment"] != null
          ? SingleAttachment.fromJson(json["attachment"])
          : null,
      attachments: (json["attachments"] as List)
          .map((e) => Attachment.fromJson(e))
          .toList(),
      attributes: (json["attributes"] as List)
          .map((e) => AttributeItem.fromJson(e))
          .toList(),
    );
  }
}

class SingleAttachment {
  final String fileName;
  final String file;

  SingleAttachment({
    required this.fileName,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      "fileName": fileName,
      "file": file,
    };
  }

  factory SingleAttachment.fromJson(Map<String, dynamic> json) {
    return SingleAttachment(
      fileName: json["fileName"],
      file: json["file"],
    );
  }
}

class Attachment {
  final String fileName;
  final String file;
  final String latt;
  final String longi;
  final String address;

  Attachment({
    required this.fileName,
    required this.file,
    required this.latt,
    required this.longi,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "fileName": fileName,
      "file": file,
      "latt": latt,
      "long": longi,
      "address": address,
    };
  }

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      fileName: json["fileName"],
      file: json["file"],
      latt: json["latt"],
      longi: json["longi"] ?? json["long"], // safe side
      address: json["address"],
    );
  }
}

class AttributeItem {
  final int attributeId;
  final String value;

  AttributeItem({
    required this.attributeId,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      "attributeId": attributeId,
      "value": value,
    };
  }

  factory AttributeItem.fromJson(Map<String, dynamic> json) {
    return AttributeItem(
      attributeId: json["attributeId"],
      value: json["value"],
    );
  }
}
