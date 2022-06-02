import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surat_jalan/models/surat_model.dart';

final dummySurat = [
  SuratModel(
    id: 1,
    userId: 2,
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    maksudPerjalanan: 'Pelatihan SOTK',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    menerimaPerintah: 'Stefan Rodrigues S.Kom',
    anggotaMengikuti: [
      "Stefan Rodrigues S.Kom",
      "Cawisadi Bakti Pranowo",
      "Sri Wahyuni"
    ],
    lokasiTujuan:
        'Kpg. Tambun No. 907, Prabumulih 48553, DIY (Kota Prabumulih) - Jawa Timur (Indonesia)',
    tglAwal: DateTime.parse("2022-06-01"),
    tglAkhir: DateTime.parse('2022-06-06'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  SuratModel(
    id: 1,
    userId: 2,
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    maksudPerjalanan: 'Kontes Hotimportnight',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    menerimaPerintah: 'Stefan Rodrigues S.Kom',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kpg. Tambun No. 907, Prabumulih 48553, DIY',
    tglAwal: DateTime.parse("2022-05-28"),
    tglAkhir: DateTime.parse('2022-06-01'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  SuratModel(
    id: 1,
    userId: 2,
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    maksudPerjalanan: 'Kontes Hotimportnight',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    menerimaPerintah: 'Stefan Rodrigues S.Kom',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kpg. Tambun No. 907, Prabumulih 48553, DIY',
    tglAwal: DateTime.parse("2022-05-28"),
    tglAkhir: DateTime.parse('2022-06-01'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  SuratModel(
    id: 1,
    userId: 2,
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    maksudPerjalanan: 'Kontes Hotimportnight',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    menerimaPerintah: 'Stefan Rodrigues S.Kom',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kpg. Tambun No. 907, Prabumulih 48553, DIY',
    tglAwal: DateTime.parse("2022-06-05"),
    tglAkhir: DateTime.parse('2022-06-12'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  SuratModel(
    id: 1,
    userId: 2,
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    maksudPerjalanan: 'Kontes Hotimportnight',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    menerimaPerintah: 'Stefan Rodrigues S.Kom',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kpg. Tambun No. 907, Prabumulih 48553, DIY',
    tglAwal: DateTime.parse("2022-06-03"),
    tglAkhir: DateTime.parse('2022-06-04'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  )
];
