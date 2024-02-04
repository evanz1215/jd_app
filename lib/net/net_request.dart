import 'package:dio/dio.dart';

class NetRequest {
  var dio = Dio();

  requestData(String path,
      {Map<String, dynamic>? queryParameters,
      dynamic data,
      String method = "get"}) async {
    var response = method == "get"
        ? await dio.get(path, queryParameters: queryParameters)
        : await dio.post(path, data: data);

    print(response);
    // return response.data;
  }
}
