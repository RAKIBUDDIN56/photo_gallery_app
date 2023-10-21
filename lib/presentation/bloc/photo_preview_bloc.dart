import 'dart:async';
import 'package:photo_gallery_app/presentation/bloc/base_bloc.dart';

import '../../data/source/network/API/api_response.dart';
import '../../data/source/network/repository/photo_repository.dart';

class PhotoPreviewBloc extends BaseBloc {
  final PhotosRepository _repo = PhotosRepository();
  final StreamController<ApiResponse<dynamic>> _scLoader =
      StreamController<ApiResponse<dynamic>>();

  StreamSink<ApiResponse<dynamic>> get loaderSink => _scLoader.sink;
  Stream<ApiResponse<dynamic>> get loaderStream => _scLoader.stream;

  void downloadPhoto(String downloadUrl, String fileName) async {
    loaderSink.add(ApiResponse.loading());

    try {
      await _repo.downloadPhoto(downloadUrl, fileName);
      loaderSink.add(ApiResponse.completed({}));
    } catch (e) {
      loaderSink.add(ApiResponse.error(e.toString()));
    }
  }

  @override
  void close() {
    _scLoader.close();
  }
}
