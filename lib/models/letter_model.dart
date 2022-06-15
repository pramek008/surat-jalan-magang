// To parse this JSON data, do
//
//     final letterModel = letterModelFromJson(jsonString);

import 'dart:convert';

class LetterModel {
  LetterModel({
    required this.id,
    required this.userId,
    required this.judul,
    required this.nomorSurat,
    required this.pemberiPerintah,
    required this.anggotaMengikuti,
    required this.lokasiTujuan,
    required this.keterangan,
    required this.tglAwal,
    required this.tglAkhir,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final UserId userId;
  final String judul;
  final String nomorSurat;
  final String pemberiPerintah;
  final List<String> anggotaMengikuti;
  final String lokasiTujuan;
  final String keterangan;
  final DateTime tglAwal;
  final DateTime tglAkhir;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory LetterModel.fromRawJson(String str) =>
      LetterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LetterModel.fromJson(Map<String, dynamic> json) => LetterModel(
        id: json["id"],
        userId: UserId.fromJson(json["user_id"]),
        judul: json["judul"],
        nomorSurat: json["nomor_surat"],
        pemberiPerintah: json["pemberi_perintah"],
        anggotaMengikuti:
            List<String>.from(json["anggota_mengikuti"].map((x) => x)),
        lokasiTujuan: json["lokasi_tujuan"],
        keterangan: json["keterangan"],
        tglAwal: DateTime.parse(json["tgl_awal"]),
        tglAkhir: DateTime.parse(json["tgl_akhir"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId.toJson(),
        "judul": judul,
        "nomor_surat": nomorSurat,
        "pemberi_perintah": pemberiPerintah,
        "anggota_mengikuti": List<dynamic>.from(anggotaMengikuti.map((x) => x)),
        "lokasi_tujuan": lokasiTujuan,
        "keterangan": keterangan,
        "tgl_awal":
            "${tglAwal.year.toString().padLeft(4, '0')}-${tglAwal.month.toString().padLeft(2, '0')}-${tglAwal.day.toString().padLeft(2, '0')}",
        "tgl_akhir":
            "${tglAkhir.year.toString().padLeft(4, '0')}-${tglAkhir.month.toString().padLeft(2, '0')}-${tglAkhir.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
