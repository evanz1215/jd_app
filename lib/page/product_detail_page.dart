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
                  buildPayContainer(context, baitiaoTitle, model, provider),
                  // 商品件數
                  buildCountContainer(model, provider)
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

  Container buildCountContainer(
      ProductDetailModel model, ProductDetailProvider provider) {
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
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              // Add your bottom sheet content here
              return ChangeNotifierProvider.value(
                value: provider,
                child: Stack(
                  children: [
                    // 頂部 圖片 價格 數量
                    Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.only(top: 20)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset(
                            "assets${model.partData?.loopImgUrl?[2]}",
                            width: 90,
                            height: 90,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "\$${model.partData?.price ?? ""}",
                              style: const TextStyle(
                                color: Color(0xffe93b3d),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "已選 ${model.partData?.count ?? 0} 件",
                              style: const TextStyle(
                                color: Color(0xff999999),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              iconSize: 20,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ))
                      ],
                    ),
                    // 中間 數量 加減號
                    Container(
                      margin: const EdgeInsets.only(top: 90.0, bottom: 50.0),
                      padding: const EdgeInsets.only(top: 40.0, left: 15.0),
                      child: Consumer<ProductDetailProvider>(
                          builder: (context, provider, child) {
                        return Row(
                          children: [
                            const Text("數量"),
                            const Spacer(),
                            InkWell(
                              child: Container(
                                width: 35,
                                height: 35,
                                color: const Color(0xfff7f7f7),
                                child: const Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xffb0b0b0)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                //減號
                                // print("-");
                                int tmpCount = model.partData?.count ?? 0;
                                tmpCount--;
                                provider.changeProductCount(tmpCount);
                              },
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Center(
                                child: Text("${model.partData?.count ?? 0}"),
                              ),
                            ),
                            const SizedBox(width: 2),
                            InkWell(
                              child: Container(
                                width: 35,
                                height: 35,
                                color: const Color(0xfff7f7f7),
                                child: const Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xffb0b0b0)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                //加號
                                int tmpCount = model.partData?.count ?? 0;
                                tmpCount++;
                                provider.changeProductCount(tmpCount);
                                // print(provider.model.partData?.count ?? 0);
                              },
                            )
                          ],
                        );
                      }),
                    ),
                    // 底部 加入購物車按鈕
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          child: Container(
                            height: 50,
                            color: const Color(0xffe4393d),
                            alignment: Alignment.center,
                            child: const Text(
                              "加入購物車",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            //加入購物車
                            print("加入購物車");
                          },
                        ))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Container buildPayContainer(BuildContext context, String baitiaoTitle,
      ProductDetailModel model, ProductDetailProvider provider) {
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
          showBaitiao(context, model, provider);
        },
      ),
    );
  }

  Future<void> showBaitiao(BuildContext context, ProductDetailModel model,
      ProductDetailProvider provider) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<ProductDetailProvider>.value(
            value: provider,
            child: Stack(
              children: [
                // 頂部標題
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      color: const Color(0xfff3f2f8),
                      child: const Center(
                        child: Text(
                          "打白條購買",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          iconSize: 20,
                          onPressed: () {
                            // 關閉彈窗
                            // Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                // 主體內容
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 50),
                  child: ListView.builder(
                      itemCount: model.baitiao?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Consumer<ProductDetailProvider>(
                                  builder: (context, provider, child) {
                                    return Image.asset(
                                      model.baitiao?[index].select == true
                                          ? "assets/image/selected.png"
                                          : "assets/image/unselect.png",
                                      width: 20.0,
                                      height: 20.0,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.baitiao?[index].desc ?? ""),
                                    Text(
                                      model.baitiao?[index].tip ?? "",
                                      // style: const TextStyle(
                                      //   color: Color(0xff999999),
                                      //   fontSize: 12.0,
                                      // ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            // 選擇分期類型
                            provider.changeBaitiaoSelected(index);
                          },
                        );
                      }),
                ),
                // 底部按鈕
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      color: const Color(0xffe4393c),
                      child: const Center(
                        child: Text(
                          "立即打白條",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      // 確定
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  Container buildPriceContainer(ProductDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Text(
        "\$${model.partData?.price ?? ""}",
        style: const TextStyle(
          color: Color(0xffe93b3d),
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
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
