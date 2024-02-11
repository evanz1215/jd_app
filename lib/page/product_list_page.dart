import 'package:flutter/material.dart';

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
          body: Container()),
    );
  }
}
