import 'package:photo_gallery_app/presentation/library.dart';

class PhotoPreviewBloc extends BaseBloc {
  final PhotosRepository _photoRepository = PhotosRepository();
  final StreamController<ApiResponse<dynamic>> _streamController =
      StreamController<ApiResponse<dynamic>>();

  StreamSink<ApiResponse<dynamic>> get loaderSink => _streamController.sink;
  Stream<ApiResponse<dynamic>> get loaderStream => _streamController.stream;

  void downloadPhoto(String downloadUrl, String fileName) async {
    loaderSink.add(ApiResponse.loading());

    try {
      await _photoRepository.downloadPhoto(downloadUrl, fileName);
      loaderSink.add(ApiResponse.completed({}));
    } catch (e) {
      loaderSink.add(ApiResponse.error(e.toString()));
    }
  }
 

  @override
  void close() {
    _streamController.close();
  }
}
