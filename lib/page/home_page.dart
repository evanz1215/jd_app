import 'package:flutter/material.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/net/net_request.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // NetRequest().requestData(JdApi.HOME_PAGE).then((res) => print(res.data));

    // netRequest();
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context) {
        var provider = HomePageProvider();
        provider.loadHomePageDate();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("首頁"),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: Consumer<HomePageProvider>(builder: (context, value, child) {
          return Container();
        }),
      ),
    );
  }
}

/// More examples see https://github.com/cfug/dio/blob/main/example
// void netRequest() async {
//   final dio = Dio();
//   final response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
