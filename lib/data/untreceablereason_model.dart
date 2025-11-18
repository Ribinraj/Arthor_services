class UntreceableReasonModels {
  final String reasonId;
  final String reason;
  final CreatedAt createdAt;
  final String modifiedAt;

  UntreceableReasonModels({
    required this.reasonId,
    required this.reason,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory UntreceableReasonModels.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UntreceableReasonModels(
        reasonId: "",
        reason: "",
        createdAt: CreatedAt.fromJson(null),
        modifiedAt: "",
      );
    }

    return UntreceableReasonModels(
      reasonId: json['reasonId']?.toString() ?? "",
      reason: json['reason']?.toString() ?? "",
      createdAt: CreatedAt.fromJson(json['created_at']),
      modifiedAt: json['modified_at']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'reasonId': reasonId,
        'reason': reason,
        'created_at': createdAt.toJson(),
        'modified_at': modifiedAt,
      };
}

class CreatedAt {
  final String dateRaw;
  final DateTime? date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.dateRaw,
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CreatedAt(
        dateRaw: "",
        date: null,
        timezoneType: 0,
        timezone: "",
      );
    }

    final rawDate = json['date']?.toString() ?? "";

    DateTime? parsed;
    if (rawDate.isNotEmpty) {
      try {
        parsed = DateTime.parse(rawDate.replaceFirst(" ", "T"));
      } catch (_) {
        parsed = null;
      }
    }

    return CreatedAt(
      dateRaw: rawDate,
      date: parsed,
      timezoneType: json['timezone_type'] is int
          ? json['timezone_type']
          : int.tryParse("${json['timezone_type']}") ?? 0,
      timezone: json['timezone']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'date': dateRaw,
        'timezone_type': timezoneType,
        'timezone': timezone,
      };
}