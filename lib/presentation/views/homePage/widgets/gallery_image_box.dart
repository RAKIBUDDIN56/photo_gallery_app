import 'package:flutter/material.dart';
import 'package:photo_gallery_app/utils/app_constant.dart';
import 'package:photo_gallery_app/utils/image_mixin.dart';
import 'package:photo_gallery_app/widgets/cached_image.dart';

class GalleryImageBox extends StatelessWidget with ImageMixin {
  const GalleryImageBox({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedImage(
      url: url,
      height: AppConstant.galleryThumbnailSize,
      width: AppConstant.galleryThumbnailSize,
    );
  }
}
