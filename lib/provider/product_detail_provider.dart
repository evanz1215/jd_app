import 'package:flutter/foundation.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/product_detail_model.dart';

import 'package:jd_app/net/net_request.dart';

class ProductDetailProvider with ChangeNotifier {
  late ProductDetailModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadProduct({String id = ""}) {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(JdApi.PRODUCTIONS_DETAIL).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductDetailModel tmpModel = ProductDetailModel.fromJson(item);
          if (tmpModel.partData?.id == id) {
            model = tmpModel;
            // print(model.partData?.id);
          }
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
