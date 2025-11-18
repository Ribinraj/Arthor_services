class CreatedAt {
  final String date;
  final int timezoneType;
  final String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CreatedAt.empty();
    return CreatedAt(
      date: (json['date']?.toString() ?? ''),
      timezoneType: int.tryParse(json['timezone_type']?.toString() ?? '') ?? 0,
      timezone: json['timezone']?.toString() ?? '',
    );
  }

  static CreatedAt empty() => CreatedAt(date: '', timezoneType: 0, timezone: '');

  Map<String, dynamic> toJson() => {
        'date': date,
        'timezone_type': timezoneType,
        'timezone': timezone,
      };
}

/// Main model for each attribute item.
class AtributesModel {
  final String attributeId;
  final String verificationTypeId;
  final String attributeName;
  final String attributeType;
  final String options; // raw options string (e.g., "Rented|Owned|leased")
  final bool isRequired;
  final int order;
  final CreatedAt createdAt;
  final String modifiedAt;
  final List<String> optionsList;

  AtributesModel({
    required this.attributeId,
    required this.verificationTypeId,
    required this.attributeName,
    required this.attributeType,
    required this.options,
    required this.isRequired,
    required this.order,
    required this.createdAt,
    required this.modifiedAt,
    required this.optionsList,
  });

  /// Parse single item from JSON, using `??` defaults to guard nulls.
  factory AtributesModel.fromJson(Map<String, dynamic> json) {
    // options_list can be null, array or empty; normalize to List<String>
    List<String> parseOptionsList(dynamic raw) {
      if (raw == null) return <String>[];
      if (raw is List) {
        return raw.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
      }
      // sometimes API sends a pipe-delimited string in `options` instead of `options_list`
      if (raw is String && raw.isNotEmpty) {
        return raw.split('|').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
      }
      return <String>[];
    }

    return AtributesModel(
      attributeId: json['attributeId']?.toString() ?? '',
      verificationTypeId: json['verificationTypeId']?.toString() ?? '',
      attributeName: json['attributeName']?.toString() ?? '',
      attributeType: json['attributeType']?.toString() ?? '',
      options: json['options']?.toString() ?? '',
      isRequired: (json['isRequired']?.toString() ?? '0') == '1',
      order: int.tryParse(json['order']?.toString() ?? '') ?? 0,
      createdAt: CreatedAt.fromJson(json['created_at'] as Map<String, dynamic>?),
      modifiedAt: json['modified_at']?.toString() ?? '',
      optionsList: parseOptionsList(json['options_list'] ?? json['options']),
    );
  }

  Map<String, dynamic> toJson() => {
        'attributeId': attributeId,
        'verificationTypeId': verificationTypeId,
        'attributeName': attributeName,
        'attributeType': attributeType,
        'options': options,
        'isRequired': isRequired ? '1' : '0',
        'order': order.toString(),
        'created_at': createdAt.toJson(),
        'modified_at': modifiedAt,
        'options_list': optionsList,
      };

  /// Helper: convert a JSON array (top-level `data`) into a List<AtributesModel>
  static List<AtributesModel> listFromJson(dynamic jsonList) {
    if (jsonList == null) return <AtributesModel>[];
    if (jsonList is List) {
      return jsonList
          .map((e) => AtributesModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    }
    return <AtributesModel>[];
  }
}