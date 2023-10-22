import 'package:photo_gallery_app/presentation/library.dart';
class PhotoWidget extends StatelessWidget  {
  const PhotoWidget({
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
