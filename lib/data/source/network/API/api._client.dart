import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../domain/models/file_response.dart';
import '../API/api_key.dart';
import 'api_exception.dart';

class ApiClient {
  Future<dynamic> get(String url) async {
    Responses returnResponse;
    Map<String, String> headers = {'Authorization': ApiKey.API_KEY};
    try {
      final response = await http.get(Uri.parse(url), headers: headers).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw FetchDataException('Request timeout');
        },
      );
      returnResponse = Responses(
          _returnResponse(response), response.statusCode, response.headers);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return returnResponse;
  }

  Future<FileResponse> getFile(String url,String fileName) async {
    FileResponse responseJson;

    try {
      final response = await http.get(Uri.parse(url));

      responseJson =
          FileResponse(fileBytes: response.bodyBytes, filename:fileName );
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isNotEmpty) {
          return response.body;
        }
        return '';
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
        throw BadRequestException(response.body);
      default:
        throw FetchDataException(
            'Network error. StatusCode : ${response.statusCode}');
    }
  }
}

class Responses<T> {
  T body;
  int statusCode;
  Map<String, dynamic> headers;

  Responses(this.body, this.statusCode, this.headers);
}
