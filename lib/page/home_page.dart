import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/net/net_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NetRequest().requestData(JdApi.HOME_PAGE);
    // netRequest();
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}

/// More examples see https://github.com/cfug/dio/blob/main/example
// void netRequest() async {
//   final dio = Dio();
//   final response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
