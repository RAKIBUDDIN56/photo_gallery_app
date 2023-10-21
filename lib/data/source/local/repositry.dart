import '../../../domain/models/photos_list_response.dart';

abstract class Repositry {
   Future<dynamic> getData(String key);

  Future<void> putPhotoData(List<Photo> response);

  Future<void> put(dynamic key, dynamic value);
}
