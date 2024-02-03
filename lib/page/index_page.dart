import 'package:flutter/material.dart';
import 'package:jd_app/page/home_page.dart';
import 'package:jd_app/page/category_page.dart';
import 'package:jd_app/page/cart_page.dart';
import 'package:jd_app/page/user_page.dart';
import 'package:jd_app/provider/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, mProvider, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // 超過3個項目時，需要設定此屬性
            currentIndex: mProvider.bottomNavIndex,
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
            onTap: (int index) {
              mProvider.changeBottomNavIndex(index);
            },
          );
        },
      ),
      body: Consumer<BottomNavProvider>(
        builder: (context, mProvider, child) {
          return IndexedStack(
            index: mProvider.bottomNavIndex,
            children: const <Widget>[
              HomePage(),
              CategoryPage(),
              CartPage(),
              UserPage(),
            ],
          );
        },
      ),
    );
  }
}
