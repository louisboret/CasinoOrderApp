import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';

import '../apis/app_exception.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class BeerService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final http.Response response = await http.get(Uri.parse(beerBaseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}
