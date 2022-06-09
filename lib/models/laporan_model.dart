// To parse this JSON data, do
//
//     final letterModel = letterModelFromJson(jsonString);

import 'dart:convert';

class LetterModel {
  LetterModel({
    required this.id,
    required this.userId,
    required this.perintahJalanId,
    required this.namaKegiatan,
    required this.foto,
    required this.lokasi,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final int perintahJalanId;
  final String namaKegiatan;
  final List<String> foto;
  final List<String> lokasi;
  final String deskripsi;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory LetterModel.fromRawJson(String str) =>
      LetterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LetterModel.fromJson(Map<String, dynamic> json) => LetterModel(
        id: json["id"],
        userId: json["user_id"],
        perintahJalanId: json["perintah_jalan_id"],
        namaKegiatan: json["nama_kegiatan"],
        foto: List<String>.from(json["foto"].map((x) => x)),
        lokasi: List<String>.from(json["lokasi"].map((x) => x)),
        deskripsi: json["deskripsi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "perintah_jalan_id": perintahJalanId,
        "nama_kegiatan": namaKegiatan,
        "foto": List<dynamic>.from(foto.map((x) => x)),
        "lokasi": List<dynamic>.from(lokasi.map((x) => x)),
        "deskripsi": deskripsi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
