// To parse this JSON data, do
//
//     final letterModel = letterModelFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'dart:convert';

class LetterModel extends Equatable {
  const LetterModel({
    required this.id,
    required this.userId,
    required this.judul,
    required this.nomorSurat,
    required this.pemberiPerintah,
    required this.penerimaPerintah,
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
  final int userId;
  final String judul;
  final String nomorSurat;
  final String pemberiPerintah;
  final String penerimaPerintah;
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
        userId: json["user_id"],
        judul: json["judul"],
        nomorSurat: json["nomor_surat"],
        pemberiPerintah: json["pemberi_perintah"],
        penerimaPerintah: json["penerima_perintah"],
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
        "user_id": userId,
        "judul": judul,
        "nomor_surat": nomorSurat,
        "pemberi_perintah": pemberiPerintah,
        "penerima_perintah": penerimaPerintah,
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

  @override
  List<Object?> get props => [
        id,
        userId,
        judul,
        nomorSurat,
        pemberiPerintah,
        penerimaPerintah,
        anggotaMengikuti,
        lokasiTujuan,
        keterangan,
        tglAwal,
        tglAkhir,
        status,
        createdAt,
        updatedAt,
      ];
}
