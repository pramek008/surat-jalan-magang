part of 'postreport_bloc.dart';

@immutable
abstract class PostreportEvent extends Equatable {
  const PostreportEvent();
}

class PostreportRequestedEvent extends PostreportEvent {
  final int userId;
  final int perintahJalanId;
  final String namaKegiatan;
  final List images;
  final List lokasi;
  final String deskripsi;

  const PostreportRequestedEvent({
    required this.userId,
    required this.perintahJalanId,
    required this.namaKegiatan,
    required this.images,
    required this.lokasi,
    required this.deskripsi,
  });

  @override
  List<Object?> get props => [
        userId,
        perintahJalanId,
        namaKegiatan,
        images,
        lokasi,
        deskripsi,
      ];
}
