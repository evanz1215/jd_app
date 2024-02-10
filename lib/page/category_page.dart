import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_app/model/category_content_model.dart';
import 'package:jd_app/provider/category_page_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // NetRequest().requestData(JdApi.HOME_PAGE).then((res) => print(res.data));

    // netRequest();
    return ChangeNotifierProvider<CategoryPageProvider>(
      create: (context) {
        var provider = CategoryPageProvider();
        provider.loadCategoryPageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("分類"),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: Container(
          color: const Color(0xFFF4F4F4),
          child: Consumer<CategoryPageProvider>(
              builder: (context, provider, child) {
            // print(provider.isLoading);
            //  加載動畫
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
                          provider.loadCategoryPageData();
                        },
                        child: const Text("重新加載")),
                  ],
                ),
              );
            }
            // print(provider.categoryNavList);

            return Row(
              children: <Widget>[
                // 分類左側
                buildNavLeftContainer(provider),
                // 分類右側
                Expanded(
                    child: buildCategoryContainer(provider.categoryContentList))
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget buildCategoryContainer(List<CategoryContentModel> contentList) {
    List<Widget> list = [];
    return Container(
      width: double.infinity,
      color: Colors.red,
      child: ListView(children: list),
    );
  }

  SizedBox buildNavLeftContainer(CategoryPageProvider provider) {
    return SizedBox(
      width: 90,
      child: ListView.builder(
        itemCount: provider.categoryNavList.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 15),
                  color: provider.tabIndex == index
                      ? Colors.white
                      : const Color(0xFFF8F8F8),
                  child: Text(
                    provider.categoryNavList[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: provider.tabIndex == index
                            ? const Color(0xFFE93b3d)
                            : const Color(0xFF333333),
                        fontWeight: FontWeight.w500),
                  )),
              onTap: () {
                // print(index);
                provider.loadCategoryContentData(index);
              });
        },
      ),
    );
  }
}
