import 'package:surat_jalan/models/letter_model.dart';

final dummySurat = [
  LetterModel(
    id: 1,
    userId: UserId(id: 1, name: 'Stefan Rodrigues S.Kom'),
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    judul: 'Pelatihan SOTK',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    anggotaMengikuti: const [
      "Stefan Rodrigues S.Kom",
      "Cawisadi Bakti Pranowo",
      "Sri Wahyuni"
    ],
    lokasiTujuan:
        'Kpg. Tambun No. 907, Prabumulih 48553, DIY (Kota Prabumulih) - Jawa Timur (Indonesia)',
    tglAwal: DateTime.parse("2022-06-07"),
    tglAkhir: DateTime.parse('2022-06-09'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  LetterModel(
    id: 1,
    userId: UserId(id: 2, name: 'Stefan Rodrigues S.Kom'),
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    judul: 'Kontes Hotimportnight',
    pemberiPerintah: 'Cawisadi Bakti Pranowo',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kpg. Tambun No. 907, Prabumulih 48553, DIY',
    tglAwal: DateTime.parse("2022-05-28"),
    tglAkhir: DateTime.parse('2022-06-01'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  LetterModel(
    id: 2,
    userId: UserId(id: 3, name: 'FADLI'),
    nomorSurat: '001.SPPD/Kec.8.8/SD/2021',
    judul: 'Pelatihan Pengelolaan Keuangan Desa Tahun Anggaran 2020',
    pemberiPerintah: 'KEPALA DESA JULI TAMBO TANJONG',
    anggotaMengikuti: [],
    lokasiTujuan: 'KANTOR CAMAT JULI',
    tglAwal: DateTime.parse("2022-05-24"),
    tglAkhir: DateTime.parse('2022-05-27'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  LetterModel(
    id: 1,
    userId: UserId(id: 3, name: 'Sinta, S.E'),
    nomorSurat: '60/77/SMA2W/2016',
    judul: 'mengadakan kontrak kerjasama dan perluasan usaha',
    pemberiPerintah: 'Sutardi, S.pd,.M.Si',
    anggotaMengikuti: [],
    lokasiTujuan: 'Semarang',
    tglAwal: DateTime.parse("2016-09-24"),
    tglAkhir: DateTime.parse('2016-09-26'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  LetterModel(
    id: 1,
    userId: UserId(id: 3, name: 'Andi Wijaya, M.Pd'),
    nomorSurat: '123/SMK.10/2016',
    judul: 'Mengikuti PLPG Gelombang I Rayon 114 UNESA 2016',
    pemberiPerintah: 'Kepala SMK Negeri 10',
    anggotaMengikuti: [],
    lokasiTujuan: 'Surabaya',
    tglAwal: DateTime.parse("2022-01-11"),
    tglAkhir: DateTime.parse('2022-01-15'),
    keterangan:
        "Perjalanan dinas dalam rangka Pelatihan SOTK Pemerintahan Desa Bagi Perangkat Desa diawal masa jabatan Angkatan II di balai Pmerintahan Desa di Lampung di Provinsi Lampung",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  ),
  LetterModel(
    id: 1,
    userId: UserId(id: 3, name: 'Jatmiko, S.E'),
    nomorSurat: '50/57/SMA3Y/2017',
    judul: 'mengadakan kontrak kerjasama',
    pemberiPerintah: 'Nanang, S.pd,.M.Si',
    anggotaMengikuti: [],
    lokasiTujuan: 'Kota Surabaya',
    tglAwal: DateTime.parse("2017-12-05"),
    tglAkhir: DateTime.parse('2017-12-15'),
    keterangan:
        "melakukan perjalanan dinas ke Kota Surabaya Dalam rangka mengadakan kontrak kerjasama dan juga perluasan usaha di daerah",
    createdAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
    updatedAt: DateTime.parse('2022-05-27T01:58:09.000000Z'),
  )
];
