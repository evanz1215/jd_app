import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_app/model/product_detail_model.dart';
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

          String baitiaoTitle = "【白條支付】首單享立減優惠";

          for (var item in model.baitiao ?? []) {
            if (item.select == true) {
              baitiaoTitle = item.desc ?? '';
              break;
            }
          }

          return Stack(
            children: [
              //主體內容
              ListView(
                children: [
                  // 輪播圖
                  buildSwiperContainer(model),
                  // 標題
                  buildTitleContainer(model),
                  // 價格
                  buildPriceContainer(model),
                  // 白條支付
                  buildPayContainer(baitiaoTitle),
                  // 商品件數
                  buildCountContainer(model)
                ],
              ),
              // 底部菜單
              buildBottomPositioned()
            ],
          );
        }),
      ),
    );
  }

  Positioned buildBottomPositioned() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xffe8e8ed), width: 1))),
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
    );
  }

  Container buildCountContainer(ProductDetailModel model) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xffe8e8ed), width: 1),
          bottom: BorderSide(color: Color(0xffe8e8ed), width: 1),
        ),
      ),
      child: InkWell(
        child: Row(
          children: [
            const Text(
              "已選",
              style: TextStyle(
                color: Color(0xff999999),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text("${model.partData?.count ?? "1"} 件"),
              ),
            ),
            const Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 選擇商品件數
        },
      ),
    );
  }

  Container buildPayContainer(String baitiaoTitle) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xffe8e8ed), width: 1),
          bottom: BorderSide(color: Color(0xffe8e8ed), width: 1),
        ),
      ),
      child: InkWell(
        child: Row(
          children: [
            const Text(
              "支付",
              style: TextStyle(
                color: Color(0xff999999),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(baitiaoTitle),
              ),
            ),
            const Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          // 選擇支付方式 白條支付 or 分期
        },
      ),
    );
  }

  Container buildPriceContainer(ProductDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Text("\$${model.partData?.price ?? ""}",
          style: const TextStyle(
            color: Color(0xffe93b3d),
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Container buildTitleContainer(ProductDetailModel model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Text(
        model.partData?.title ?? "",
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildSwiperContainer(ProductDetailModel model) {
    return Container(
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
    );
  }
}
