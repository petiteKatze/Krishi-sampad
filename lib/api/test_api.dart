import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const baseUrl = "https://jsonplaceholder.typicode.com/h";
final dio = Dio();

testApi() async {
  try {
    final res = await dio.get(baseUrl);

  } catch (error) {
    if (error is DioException) {
      if (error.response != null) {
        if (kDebugMode) {
          print(
              'Request failed with status code ${error.response!.statusCode}');
          print('Response data: ${error.response!.data}');
        }
      } else {
        if (kDebugMode) {
          print('Request failed: ${error.message}');
        }
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error: $error');
      }
    }
  }
}

getApiWithToken(String path, String token) async {}
