import 'package:flutter/material.dart';
import 'package:photo_gallery_app/config/route/routes_name.dart';
import 'package:photo_gallery_app/presentation/bloc/home_bloc.dart';
import 'package:photo_gallery_app/presentation/views/homePage/widgets/gallery_image_box.dart';
import '../../../data/source/network/API/api_response.dart';
import '../../../domain/models/photos_list_response.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/utility.dart';
import 'package:photo_gallery_app/widgets/error.dart';
import '../photoPreviewPage/photo_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  _initialization() {
    _homeBloc.requestNextPageStream.listen((event) {
      if (event.status == Status.loading) {
      } else if (event.status == Status.completed) {
        setState(() {});
      } else if (event.status == Status.error) {
        showSnackBar(context, event.message, true);
      }
    });

    _homeBloc.getInitialPhotosList();
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return StreamBuilder<ApiResponse<List<Photo>>>(
      stream: _homeBloc.photosListStream,
      builder: (context, snapshot) {
        if (snapshot.data?.status == Status.loading) {
          return Center(
            child: showLoader(context),
          );
        } else if (snapshot.data?.status == Status.completed) {
         
          return photosGridView();
        } else if (snapshot.data?.status == Status.error) {
          return Error(
              errorMessage: snapshot.data?.message,
              onRetryPressed: () => _homeBloc.getInitialPhotosList());
        }

        return const SizedBox.shrink();
      },
    );
  }

 

  Widget photosGridView() {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: _homeBloc.scrollController,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.PHOTO_PREVEW,
                    arguments: PhotoPreviewScreenArgs(
                      photoList: _homeBloc.photoList,
                      index: index,
                    ),
                  );
                },
                child:
                    GalleryImageBox(url: _homeBloc.photoList[index].imageUrl),
              );
            },
            itemCount: _homeBloc.photoList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width /
                      AppConstant.galleryThumbnailSize)
                  .round(),
              crossAxisSpacing: AppConstant.galleryCrossAxisSpacing,
              mainAxisSpacing: AppConstant.galleryMainAxisSpacing,
            ),
            scrollDirection: Axis.vertical,
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Photo Gallery',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

 
}
