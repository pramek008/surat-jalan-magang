import 'dart:convert';

class InformationModel {
  InformationModel({
    required this.id,
    required this.appInfo,
    required this.logoMain,
    required this.mainColor,
    required this.startedAt,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? appInfo;
  final String? logoMain;
  final String? mainColor;
  final DateTime? startedAt;
  final DateTime? expiredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory InformationModel.fromRawJson(String str) =>
      InformationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      InformationModel(
        id: json["id"] as int,
        appInfo: json["app_info"] as String,
        logoMain: json["logo_main"] as String,
        mainColor: json["main_color"] as String,
        startedAt: DateTime.parse(json["started_at"] as String),
        expiredAt: DateTime.parse(json["expired_at"] as String),
        createdAt: DateTime.parse(json["created_at"] as String),
        updatedAt: DateTime.parse(json["updated_at"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_info": appInfo,
        "logo_main": logoMain,
        "main_color": mainColor,
        "started_at": startedAt?.toIso8601String(),
        "expired_at": expiredAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
