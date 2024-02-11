import 'package:flutter/foundation.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/product_info_model.dart';
import 'package:jd_app/net/net_request.dart';

class ProductListProvider with ChangeNotifier {
  late ProductInfoModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = [];

  loadProductList() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(JdApi.PRODUCTIONS_LIST).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductInfoModel tmpModel = ProductInfoModel.fromJson(item);
          list.add(tmpModel);
        }
      }
      // else {
      //   print(res.message);
      //   isError = true;
      //   errorMsg = res.message;
      // }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }
}
