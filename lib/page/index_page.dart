import 'package:flutter/material.dart';
import 'package:jd_app/page/home_page.dart';
import 'package:jd_app/page/category_page.dart';
import 'package:jd_app/page/cart_page.dart';
import 'package:jd_app/page/user_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 超過3個項目時，需要設定此屬性
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首頁",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "分類",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "購物車",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "我的",
          ),
        ],
      ),
      body: const IndexedStack(
        index: 0,
        children: <Widget>[
          HomePage(),
          CategoryPage(),
          CartPage(),
          UserPage(),
        ],
      ),
    );
  }
}
