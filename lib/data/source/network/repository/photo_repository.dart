import 'package:photo_gallery_app/data/library.dart';

import '../API/api._client.dart';
import '../API/api_endpoints.dart';
import '../API/base_url.dart';

class PhotosRepository extends Repository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Response<List<Photo>>> fetchPhotosList(int pageNumber) async {
    final Response response = await _apiClient.get(
        '${BaseURL.baseURL}${Endpoints.photos}/?page=$pageNumber&limit=${AppConstant.photoListLimit}');
    return Response(photoModelFromJson(response.body), response.statusCode,
        response.headers);
  }

  @override
  Future<String> downloadPhoto(String downloadUrl, String fileName) async {
    final FileResponse response =
        await _apiClient.getFile(downloadUrl, fileName);
    return savePhoto(response);
  }

  Future<String> savePhoto(FileResponse response) async {
    try {
      String path = '';
      if (Platform.isAndroid) {
        path = "/storage/emulated/0/Download";
      } else if (Platform.isIOS) {
        path = (await getApplicationDocumentsDirectory()).path;
      } else {
        throw Exception('Platform not supported yet');
      }
      if (!await Directory(path).exists()) await Directory(path).create();
      String filePath = '$path/image${response.filename}.jpg';
      File file = File(filePath);
      int count = 1;
      while (await file.exists() == true) {
        filePath = '$path/image${response.filename}($count).jpg';
        file = File(filePath);
        count++;
      }
      file = await file.writeAsBytes(response.fileBytes);

      return filePath;
    } catch (error) {
      debugPrint(error.toString());
      return "";
    }
  }
}
