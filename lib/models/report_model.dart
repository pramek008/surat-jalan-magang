// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ReportModel {
  ReportModel({
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
  final UserId userId;
  final PerintahJalanId perintahJalanId;
  final String namaKegiatan;
  final List<String> foto;
  final List<String> lokasi;
  final String deskripsi;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ReportModel.fromRawJson(String str) =>
      ReportModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"],
        userId: UserId.fromJson(json["user_id"]),
        perintahJalanId: PerintahJalanId.fromJson(json["perintah_jalan_id"]),
        namaKegiatan: json["nama_kegiatan"],
        foto: List<String>.from(json["foto"].map((x) => x)),
        lokasi: List<String>.from(json["lokasi"].map((x) => x)),
        deskripsi: json["deskripsi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId.toJson(),
        "perintah_jalan_id": perintahJalanId.toJson(),
        "nama_kegiatan": namaKegiatan,
        "foto": List<dynamic>.from(foto.map((x) => x)),
        "lokasi": List<dynamic>.from(lokasi.map((x) => x)),
        "deskripsi": deskripsi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PerintahJalanId {
  PerintahJalanId({
    required this.id,
    required this.judul,
    required this.nomorSurat,
    required this.tglAwal,
    required this.tglAkhir,
    required this.tujuan,
  });

  final int id;
  final String judul;
  final String nomorSurat;
  final DateTime tglAwal;
  final DateTime tglAkhir;
  final String tujuan;

  factory PerintahJalanId.fromRawJson(String str) =>
      PerintahJalanId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PerintahJalanId.fromJson(Map<String, dynamic> json) =>
      PerintahJalanId(
        id: json["id"],
        judul: json["judul"],
        nomorSurat: json["nomor_surat"],
        tglAwal: DateTime.parse(json["tgl_awal"]),
        tglAkhir: DateTime.parse(json["tgl_akhir"]),
        tujuan: json["tujuan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "nomor_surat": nomorSurat,
        "tgl_awal":
            "${tglAwal.year.toString().padLeft(4, '0')}-${tglAwal.month.toString().padLeft(2, '0')}-${tglAwal.day.toString().padLeft(2, '0')}",
        "tgl_akhir":
            "${tglAkhir.year.toString().padLeft(4, '0')}-${tglAkhir.month.toString().padLeft(2, '0')}-${tglAkhir.day.toString().padLeft(2, '0')}",
        "tujuan": tujuan,
      };
}

class UserId {
  UserId({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory UserId.fromRawJson(String str) => UserId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
