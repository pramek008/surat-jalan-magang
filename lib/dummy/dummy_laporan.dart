import 'package:surat_jalan/models/report_model.dart';

final dummyReport = [
  ReportModel(
    id: 1,
    userId: UserId(
      id: 1,
      name: "Rizki",
    ),
    perintahJalanId: PerintahJalanId(
      id: 1,
      judul: "Perintah Jalan 1",
      nomorSurat: '005/SPD/2022',
      tglAkhir: DateTime.parse('2022-02-20'),
      tglAwal: DateTime.parse('2022-02-20'),
      tujuan: 'Ki. Taman No. 692, Singkawang 10937, Banten',
    ),
    namaKegiatan: 'Pengadaan Barang',
    foto: [
      "post-foto\\/IGE0oRZjFgMuxW8mcaHapkrvLyyoV280qpUT69Zk.jpg",
      "post-foto\\/2EVGTjDR2GWkn2ruPfUCJm5XJI1pho2pcs0CPRkE.jpg",
      "post-foto\\/4TtzFTpwzFafePGb6Q0k0qp9pmYoiCEVTWPMqVug.jpg"
    ],
    lokasi: [
      "-7.7148361",
      "109.9906265",
    ],
    deskripsi:
        'Membahas tentang perlunya peningkatan pelayanan kesehatan dan perbaikan jalan yang merata di setiap daerah',
    createdAt: DateTime.parse('2022-06-10T07:17:52.000000Z'),
    updatedAt: DateTime.parse('2022-06-10T07:17:52.000000Z'),
  )
];
