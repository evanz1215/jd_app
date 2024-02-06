import 'package:dio/dio.dart';

class ComResponse<T> {
  int code;
  String message;
  T data;

  ComResponse({required this.code, required this.message, required this.data});
}

class NetRequest {
  var dio = Dio();

  Future<ComResponse<T>> requestData<T>(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      String method = "get"}) async {
    try {
      var response = method == "get"
          ? await dio.get(path, queryParameters: queryParameters)
          : await dio.post(path, data: data);

      return ComResponse(
          code: response.data['code'],
          message: response.data['msg'],
          data: response.data['data']);
    } on DioException catch (e) {
      print(e.message);

      String message = e.message ?? "";
      if (e.type == DioExceptionType.connectionTimeout) {
        message = "Connection timeout";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        message = "Receive timeout";
      } else if (e.type == DioExceptionType.badResponse) {
        message = "404 Not Found ${e.response?.statusCode}";
      }

      return Future.error(message);
    }
  }
}
