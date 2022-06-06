import 'dart:convert';
import 'package:equatable/equatable.dart';

class SuratModel extends Equatable {
  final int id;
  final int userId;
  final String maksudPerjalanan;
  final String nomorSurat;
  final String pemberiPerintah;
  final String penerimaPerintah;
  final List<String> anggotaMengikuti;
  final String lokasiTujuan;
  final DateTime tglAwal;
  final DateTime tglAkhir;
  final String keterangan;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SuratModel({
    required this.id,
    required this.userId,
    required this.maksudPerjalanan,
    required this.nomorSurat,
    required this.pemberiPerintah,
    required this.penerimaPerintah,
    this.anggotaMengikuti = const [],
    required this.lokasiTujuan,
    required this.tglAwal,
    required this.tglAkhir,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SuratModel.fromRawJson(String str) =>
      SuratModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuratModel.fromJson(Map<String, dynamic> json) => SuratModel(
        id: json["id"],
        userId: json["user_id"],
        maksudPerjalanan: json["maksudPerjalanan"],
        nomorSurat: json["nomor_surat"],
        pemberiPerintah: json["pemberi_perintah"],
        penerimaPerintah: json["menerima_perintah"],
        anggotaMengikuti:
            List<String>.from(json["anggota_mengikuti"].map((x) => x)),
        lokasiTujuan: json["lokasi_tujuan"],
        tglAwal: DateTime.parse(json["tgl_awal"]),
        tglAkhir: DateTime.parse(json["tgl_akhir"]),
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "maksudPerjalanan": maksudPerjalanan,
        "nomor_surat": nomorSurat,
        "pemberi_perintah": pemberiPerintah,
        "menerima_perintah": penerimaPerintah,
        "anggota_mengikuti": List<dynamic>.from(anggotaMengikuti.map((x) => x)),
        "lokasi_tujuan": lokasiTujuan,
        "tgl_awal":
            "${tglAwal.year.toString().padLeft(4, '0')}-${tglAwal.month.toString().padLeft(2, '0')}-${tglAwal.day.toString().padLeft(2, '0')}",
        "tgl_akhir":
            "${tglAkhir.year.toString().padLeft(4, '0')}-${tglAkhir.month.toString().padLeft(2, '0')}-${tglAkhir.day.toString().padLeft(2, '0')}",
        "keterangan": keterangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        userId,
        maksudPerjalanan,
        nomorSurat,
        pemberiPerintah,
        penerimaPerintah,
        anggotaMengikuti,
        lokasiTujuan,
        tglAwal,
        tglAkhir,
        keterangan,
        createdAt,
        updatedAt,
      ];
}
