import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/model/product_info_model.dart';
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
                  return;
                },
              );
            }),
          )),
    );
  }
}
