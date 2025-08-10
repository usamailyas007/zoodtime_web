
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:zoodtime_admin/services/storage.dart';

class DioConfig {
  var dio = Dio();
  DioConfig() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String token  = await Storage.getToken();
          options.headers['Content-Type'] = 'application/json';
          options.headers["authorization"] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (e, handler) async {
          return handler.next(e);
        },
        onError: (e, handler) async {
          return handler.next(e);
        },
      ),
    );
  }
}

class Req {
  var interceptor = DioConfig();

  get(String url) async {
    try {
      var resp = await interceptor.dio.get(url);
      return resp.data;
    } on DioException catch (e) {
      return {"status": e.response?.statusCode.toString()};
    }
  }

  getWithData(String url, data) async {
    try {
      var resp = await interceptor.dio.get(url,data: data);
      return resp.data;
    } on DioException catch (e) {
      return {"status": e.response?.statusCode.toString()};
    }
  }


  // post(String url, data) async {
  //   try {
  //     var resp = await interceptor.dio.post(url, data: data);
  //     return resp.data;
  //   } on DioException catch (e) {
  //     print(e.response?.statusCode.toString());
  //     return {"status": e.response?.statusCode.toString()};
  //   }
  // }

  post(String url, data) async {
    try {
      var resp = await interceptor.dio.post(url, data: data);
      return resp.data;
    } on DioException catch (e) {
      log("Error: ${e.response?.data}");
      return e.response?.data ?? {"status": e.response?.statusCode.toString()};
    }
  }

  postReq(String url) async {
    try {
      var resp = await interceptor.dio.post(url);
      return resp.data;
    } on DioException catch (e) {
      print(e.response?.statusCode.toString());
      return {"status": e.response?.statusCode.toString()};
    }
  }

  getReq(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      var resp = await interceptor.dio.get(
        url,
        queryParameters: queryParams,
      );
      return resp.data;
    } on DioException catch (e) {
      return {"status": e.response?.statusCode.toString()};
    }
  }

  Future<dynamic> multipartPost(
      String url,
      Map<String, dynamic> fields, [
        Uint8List? imageBytes,
      ]) async {
    try {
      FormData formData = FormData();

      fields.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      if (imageBytes != null && imageBytes.isNotEmpty) {
        formData.files.add(MapEntry(
          'profile',
          MultipartFile.fromBytes(
            imageBytes,
            filename: 'profile.png',
            contentType: MediaType('image', 'png'),
          ),
        ));
      }

      var resp = await interceptor.dio.post(
        url,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return resp.data;
    } on DioException catch (e) {
      log("Multipart error: ${e.response?.data}");
      return e.response?.data ?? {"status": e.response?.statusCode.toString()};
    }
  }

  Future<dynamic> multipartPostAppSetting(
      String url,
      Map<String, dynamic> fields, [
        Uint8List? imageBytes,
      ]) async {
    try {
      FormData formData = FormData();

      fields.forEach((key, value) {
        if (value is List || value is Map) {
          formData.fields.add(MapEntry(key, jsonEncode(value)));
        } else {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });

      if (imageBytes != null && imageBytes.isNotEmpty) {
        formData.files.add(MapEntry(
          'appLogo', // ✅ Matches backend's upload.single('appLogo')
          MultipartFile.fromBytes(
            imageBytes,
            filename: 'app_logo.png',
            contentType: MediaType('image', 'png'),
          ),
        ));
      }

      var resp = await interceptor.dio.post(
        url,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      print("response in multipart ================${resp.data}");

      return resp.data;
    } on DioException catch (e) {
      log("Multipart error: ${e.response?.data}");
      return e.response?.data ?? {"status": e.response?.statusCode.toString()};
    }
  }



}

