import '../../../../domain/models/photos_list_response.dart';

import '../API/api._client.dart';

abstract class Repository {
  Future<Responses<List<Photo>>> fetchPhotosList(int pageNumber);
  Future<String> downloadPhoto(String downloadUrl, String fileName);
}
