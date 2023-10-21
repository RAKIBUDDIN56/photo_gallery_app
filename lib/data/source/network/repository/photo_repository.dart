import 'package:photo_gallery_app/data/source/network/repository/repository.dart';

import 'package:photo_gallery_app/utils/app_constant.dart';
import 'package:photo_gallery_app/utils/utility.dart';

import '../../../../domain/models/file_response.dart';
import '../../../../domain/models/photos_list_response.dart';
import '../API/api._client.dart';
import '../API/api_endpoints.dart';
import '../API/base_url.dart';

class PhotosRepository extends Repository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Responses<List<Photo>>> fetchPhotosList(int pageNumber) async {
    final Responses response = await _apiClient.get(
        '${BaseURL.baseURL}${Endpoints.photos}/?page=$pageNumber&limit=${AppConstant.photoListLimit}');
    return Responses(photoModelFromJson(response.body), response.statusCode,
        response.headers);
  }

  @override
  Future<String> downloadPhoto(String downloadUrl, String fileName) async {
    final FileResponse response =
        await _apiClient.getFile(downloadUrl, fileName);
    return savePhoto(response);
  }
}
