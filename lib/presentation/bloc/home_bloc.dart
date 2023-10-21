import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:photo_gallery_app/data/source/local/repository_local.dart';
import 'package:photo_gallery_app/data/source/network/API/api._client.dart';
import 'package:photo_gallery_app/presentation/bloc/base_bloc.dart';

import '../../data/source/network/API/api_response.dart';
import '../../data/source/network/repository/photo_repository.dart';
import '../../domain/models/photos_list_response.dart';
import '../../utils/app_hive.dart';

class HomeBloc extends BaseBloc {
  final PhotosRepository _photoRepository = PhotosRepository();
  final RepositoryLocal _repositoryLocal = RepositoryLocal();
  final ScrollController _scrollController = ScrollController();

  final StreamController<ApiResponse<List<Photo>>> _photosListStreamControler =
      StreamController<ApiResponse<List<Photo>>>();
  final StreamController<ApiResponse<List<Photo>>>
      _requestNextPageStreamController =
      StreamController<ApiResponse<List<Photo>>>();

  ScrollController get scrollController => _scrollController;
  StreamSink<ApiResponse<List<Photo>>> get photosListSink =>
      _photosListStreamControler.sink;
  Stream<ApiResponse<List<Photo>>> get photosListStream =>
      _photosListStreamControler.stream;

  StreamSink<ApiResponse<List<Photo>>> get requestNextPageSink =>
      _requestNextPageStreamController.sink;
  Stream<ApiResponse<List<Photo>>> get requestNextPageStream =>
      _requestNextPageStreamController.stream;

  final List<Photo> _photoList = [];
  List<Photo> get photoList => _photoList;
  int pageNumber = 1;
  bool hasNextPage = true;

  HomeBloc() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          hasNextPage) {
        requestNextPage();
      }
    });
  }

  void fetchPhotoList(StreamSink<ApiResponse<List<Photo>>> sink,
      [bool checkDB = false]) async {
    sink.add(ApiResponse.loading());

    try {
      var photoListBox = await Hive.openBox<Photo>(AppHive.photoListBox);
      // var photoGalleryBox = await Hive.openBox(AppHive.photoGalleryBox);

      if (checkDB && photoListBox.values.isNotEmpty) {
        _photoList.addAll(photoListBox.values);
        hasNextPage = await _repositoryLocal.getData(AppHive.hasNextPageKey);
        pageNumber = await _repositoryLocal.getData(AppHive.nextPageNumberKey);

        sink.add(ApiResponse.completed(null));

        return;
      }

      if (hasNextPage) {
        final Responses<List<Photo>> response =
            await _photoRepository.fetchPhotosList(pageNumber);

        if (response.headers['link'].toString().contains('rel="next"')) {
          hasNextPage = true;
          pageNumber++;
        } else {
          hasNextPage = false;
        }

        _photoList.addAll(response.body);

        // Store information to DB
        _repositoryLocal.putPhotoData(response.body);
        // photoListBox.addAll(response.body);

        _repositoryLocal.put(AppHive.nextPageNumberKey, pageNumber);
        _repositoryLocal.put(AppHive.hasNextPageKey, hasNextPage);
      }

      sink.add(ApiResponse.completed(null));
    } catch (e) {
      sink.add(ApiResponse.error(e.toString()));
    }
  }

  void getInitialPhotosList() async {
    fetchPhotoList(photosListSink, true);
  }

  void requestNextPage() async {
    fetchPhotoList(requestNextPageSink);
  }

  @override
  void close() {
    _photosListStreamControler.close();
    _requestNextPageStreamController.close();
    _scrollController.dispose();
    Hive.close();
  }
}
