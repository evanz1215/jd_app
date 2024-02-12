import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/model/product_info_model.dart';
import 'package:jd_app/page/product_detail_page.dart';
import 'package:jd_app/provider/product_detail_provider.dart';
import 'package:jd_app/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  const ProductListPage({super.key, required this.title});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Container(
            color: const Color(0xfff7f7f7),
            child: Consumer<ProductListProvider>(
                builder: (context, provider, child) {
              //  加載中
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
                            provider.loadProductList();
                          },
                          child: const Text("重新加載")),
                    ],
                  ),
                );
              }

              // 返回數據展示
              return ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  ProductInfoModel model = provider.list[index];
                  // print(model.toJson());
                  return InkWell(
                    child: buildProductItem(model),
                    onTap: () {
                      // print("點擊了商品:${model.title}");

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<ProductDetailProvider>(
                          create: (context) {
                            var provider = ProductDetailProvider();
                            provider.loadProduct(id: model.id ?? '');
                            return provider;
                          },
                          child: Consumer<ProductDetailProvider>(
                              builder: (context, provider, child) {
                            return Container(
                              child: ProductDetailPage(id: model.id ?? ''),
                            );
                          }),
                        ),
                      ));
                    },
                  );
                },
              );
            }),
          )),
    );
  }

  Row buildProductItem(ProductInfoModel model) {
    return Row(
      children: [
        Image.asset(
          "assets${model.cover}",
          width: 95,
          height: 120,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "\$${model.price}",
                style:
                    const TextStyle(fontSize: 16.0, color: Color(0xffe93b3d)),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    "${model.comment}條評價",
                    style: const TextStyle(
                        fontSize: 13.0, color: Color(0xff999999)),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "好評率${model.rate}",
                    style: const TextStyle(
                        fontSize: 13.0, color: Color(0xff999999)),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        )),
      ],
    );
  }
}
