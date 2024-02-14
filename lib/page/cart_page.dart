import 'package:flutter/material.dart';
import 'package:jd_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("購物車"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(builder: (context, provider, child) {
        if (provider.models.isEmpty) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image.asset(
                    "assets/image/shop_cart.png",
                    width: 90,
                    height: 90,
                  ),
                ),
                const Text(
                  "購物車是空的，快去選購吧",
                  style: TextStyle(fontSize: 16, color: Color(0xff999999)),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("購物車不是空的"),
          );
        }
      }),
    );
  }
}
