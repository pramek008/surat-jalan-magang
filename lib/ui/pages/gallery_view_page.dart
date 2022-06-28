import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryViewPage extends StatefulWidget {
  final PageController? pageController;
  final List<String> images;
  final int index;
  GalleryViewPage({
    Key? key,
    required this.images,
    this.index = 0,
  })  : pageController = PageController(initialPage: index),
        super(key: key);

  @override
  State<GalleryViewPage> createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        pageController: widget.pageController,
        itemCount: widget.images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
                "http://103.100.27.29/sppd/public/storage/${widget.images[index]}"),
            // initialScale: PhotoViewComputedScale.contained * 1,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 4,
          );
        },
      ),
    );
  }
}
