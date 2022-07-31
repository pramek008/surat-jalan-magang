part of 'letter_bloc.dart';

@immutable
abstract class LetterEvent extends Equatable {
  const LetterEvent();
}

class LetterPutEvent extends LetterEvent {
  final int id;
  final int userId;
  final String judul;
  final String nomorSurat;
  final String pemberiPerintah;
  final List<String> anggotaMengikuti;
  final String lokasiTujuan;
  final String keterangan;
  final DateTime tglAwal;
  final DateTime tglAkhir;
  final bool diserahkan;

  const LetterPutEvent({
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
    required this.diserahkan,
  });

  @override
  List<Object?> get props => [
        userId,
        judul,
        nomorSurat,
        pemberiPerintah,
        anggotaMengikuti,
        lokasiTujuan,
        keterangan,
        tglAwal,
        tglAkhir,
        diserahkan,
      ];
}
