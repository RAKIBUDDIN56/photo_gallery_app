import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery_app/utils/utility.dart';
import 'package:photo_gallery_app/widgets/loader_dialog.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../data/source/network/API/api_response.dart';
import '../../../domain/models/photos_list_response.dart';
import '../../../utils/app_permission_handler.dart';
import '../../bloc/photo_preview_bloc.dart';
import 'widgets/photo_download_button.dart';

class PhotoPreviewScreen extends StatefulWidget {
  final PhotoPreviewScreenArgs args;
  const PhotoPreviewScreen({Key? key, required this.args}) : super(key: key);
  @override
  State<PhotoPreviewScreen> createState() =>
      _PhotoPreviewScreenState(args.photoList, args.index);
}

class _PhotoPreviewScreenState extends State<PhotoPreviewScreen> {
  List<Photo> photoList;
  int index;

  late int _currentIndex;
  late PageController _pageController;
  final PhotoPreviewBloc _bloc = PhotoPreviewBloc();

  _PhotoPreviewScreenState(this.photoList, this.index);

  @override
  void initState() {
    super.initState();

    _currentIndex = index;
    _pageController = PageController(initialPage: index);

    _bloc.loaderStream.listen((event) {
      if (event.status == Status.loading) {
        DialogBuilder(context).showLoader();
      } else if (event.status == Status.completed) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, "Photo downloaded to Download folder");
      } else if (event.status == Status.error) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            photoView(),
            Positioned(top: 40, right: 10, child: photoDownload())
          ],
        ),
      ),
    );
  }

  Widget photoView() {
    return PhotoViewGallery.builder(
      pageController: _pageController,
      itemCount: photoList.length,
      enableRotation: true,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(photoList[index].imageUrl),
        );
      },
      loadingBuilder: (context, event) {
        return CupertinoActivityIndicator(
          color: Theme.of(context).colorScheme.secondary,
        );
      },
      onPageChanged: (index) {
        _currentIndex = index;
      },
    );
  }

  Widget photoDownload() {
    return Container(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhotoDownloadButton(
            iconData:
                Platform.isIOS ? CupertinoIcons.cloud_download : Icons.download,
            onPressed: () async {
              bool res = await AppPermissionHandler().hasStoragePermission();
              debugPrint(res.toString());
              if (res) {
                _bloc.downloadPhoto(photoList[_currentIndex].imageUrl,
                    photoList[_currentIndex].id);
              } else {
                if (context.mounted) {
                  showSnackBar(context, "Storage permission is required");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class PhotoPreviewScreenArgs {
  List<Photo> photoList;
  int index;

  PhotoPreviewScreenArgs({required this.photoList, required this.index});
}
