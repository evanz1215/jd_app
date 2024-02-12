import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_app/provider/product_detail_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品詳情"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xfff7f7f7),
        child: Consumer<ProductDetailProvider>(
            builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
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
                        provider.loadProduct(id: widget.id);
                      },
                      child: const Text("重新加載")),
                ],
              ),
            );
          }

          var model = provider.model;

          return Stack(
            children: [
              //主體內容
              ListView(
                children: [
                  // 輪播圖
                  Container(
                    color: Colors.white,
                    height: 400,
                    child: Swiper(
                      itemCount: model.partData?.loopImgUrl?.length ?? 0,
                      pagination: const SwiperPagination(),
                      autoplay: true,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          "assets${model.partData?.loopImgUrl?[index]}",
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  // 標題
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      model.partData?.title ?? "",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // 價格
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    child: Text("\$${model.partData?.price ?? ""}",
                        style: const TextStyle(
                          color: Color(0xffe93b3d),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                  // 白條支付
                  // 商品件數
                ],
              ),
              // 底部菜單
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Color(0xffe8e8ed), width: 1))),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: 60,
                            color: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart),
                                Text(
                                  "購物車",
                                  style: TextStyle(fontSize: 13.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                            height: 60,
                            color: const Color(0xffe93b3d),
                            alignment: Alignment.center,
                            child: const Text(
                              "加入購物車",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ))
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
