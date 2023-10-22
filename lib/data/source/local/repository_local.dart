import 'package:photo_gallery_app/data/library.dart';

class RepositoryLocal extends Repositry {
  @override
   Future<dynamic> getData(String key) async {
    var photoGalleryBox = await Hive.openBox(AppHive.photoGalleryBox);
    return photoGalleryBox.get(key);
  }

  @override
  Future<void> putPhotoData(List<Photo> response) async {
    var photoListBox = await Hive.openBox<Photo>(AppHive.photoListBox);
    photoListBox.addAll(response);
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    var photoGalleryBox = await Hive.openBox(AppHive.photoGalleryBox);
    photoGalleryBox.put(key, value);
  }
}
