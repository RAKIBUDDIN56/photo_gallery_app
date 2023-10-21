import 'dart:convert';
import 'package:hive/hive.dart';
part 'photos_list_response.g.dart';

List<Photo> photoModelFromJson(String str) =>
    List<Photo>.from(json.decode(str).map((x) => Photo.fromJson(x)));

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int width;
  @HiveField(2)
  final int height;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String imageUrl;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.description,
    required this.imageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        description: json["description"],
        imageUrl: json["urls"]["regular"],
      );
}
