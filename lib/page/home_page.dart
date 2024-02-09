import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_app/model/home_page_model.dart';
import 'package:jd_app/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';

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
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("首頁"),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: const Color(0xFFF4F4F4),
          child:
              Consumer<HomePageProvider>(builder: (context, provider, child) {
            // print(provider.isLoading);
            //  加載動畫
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            //  加載錯誤
            if (provider.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(provider.errorMsg),
                    OutlinedButton(
                        onPressed: () {
                          provider.loadHomePageData();
                        },
                        child: const Text("重新加載")),
                  ],
                ),
              );
            }

            HomePageModel model = provider.model;
            print(model.toJson());

            return ListView(
              children: <Widget>[
                // 輪播圖
                buildAspectRatio(model),
                // 圖標分類
                buildLogos(model),
                // 掌上秒殺頭部
                buildMSHeaderContainer(),
                // 掌上秒殺商品
                buildMSBodyContainer(model),
                // 廣告1
                buildAds(model.pageRow?.ad1 ?? []),
                // 廣告2
                buildAds(model.pageRow?.ad2 ?? []),
              ],
            );
          }),
        ),
      ),
    );
  }

  // 廣告
  Widget buildAds(List<String> ads) {
    List<Widget> list = [];
    for (var i = 0; i < ads.length; i++) {
      list.add(Expanded(
        child: Image.asset(
          "assets${ads[i]}",
          // fit: BoxFit.cover,
        ),
      ));
    }
    return Row(
      children: list,
    );
  }

  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.quicks?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Image.asset(
                  "assets${model.quicks?[index].image}",
                  width: 85,
                  height: 85,
                ),
                Text(
                  "${model.quicks?[index].price}",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildMSHeaderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      height: 50,
      child: Row(
        children: [
          Image.asset(
            "assets/image/bej.png",
            width: 90,
            height: 20,
          ),
          const Spacer(),
          const Text("更多秒殺"),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          )
        ],
      ),
    );
  }

  // 輪播圖
  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
          itemCount: model.swipers?.length ?? 0,
          pagination: const SwiperPagination(),
          autoplay: true,
          itemBuilder: (context, index) =>
              Image.asset("assets${model.swipers?[index].image}")),
    );
  }

  // 圖標分類
  Widget buildLogos(HomePageModel model) {
    List<Widget> list = [];

    if (model.logos != null) {
      for (var i = 0; i < model.logos!.length; i++) {
        list.add(SizedBox(
          width: 60.0,
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets${model.logos?[i].image}",
                width: 50,
                height: 50,
              ),
              Text(model.logos?[i].title ?? "")
            ],
          ),
        ));
      }
    }

    return Container(
        color: Colors.white,
        height: 170,
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 7.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.spaceBetween,
          children: list,
        ));
  }
}

/// More examples see https://github.com/cfug/dio/blob/main/example
// void netRequest() async {
//   final dio = Dio();
//   final response = await dio.get(JdApi.HOME_PAGE);
//   print(response.data);
// }
