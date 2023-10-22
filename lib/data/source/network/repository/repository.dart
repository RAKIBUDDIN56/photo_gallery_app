
import 'package:photo_gallery_app/data/library.dart';
import '../API/api._client.dart';
abstract class Repository {
  Future<Response<List<Photo>>> fetchPhotosList(int pageNumber);
  Future<String> downloadPhoto(String downloadUrl, String fileName);
}
