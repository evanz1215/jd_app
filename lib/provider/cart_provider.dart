import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jd_app/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];

  Future<void> addToCart(PartData data) async {
    // print(data.toJson());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 存入緩存
    // List<String> list = [];
    // list.add(json.encode(data.toJson()));
    // prefs.setStringList("cartInfo", list);

    // 取出緩存
    // list = prefs.getStringList("cartInfo") ?? [];
    // print(list);

    List<String> list = [];

    // 先把緩存取出來
    list = prefs.getStringList("cartInfo") ?? [];

    // 判斷取出來的list是否為空
    if (list.isEmpty) {
      // print("沒數據");
      list.add(json.encode(data.toJson()));
      prefs.setStringList("cartInfo", list);
      // 更新本地數據
      models.add(data);
      notifyListeners();
    } else {
      // print("有數據");
      // 判斷是否有重複的數據
      List<String> tmpList = [];
      bool isUpdated = false;
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        if (tmpData.id == data.id) {
          // tmpData.count = tmpData.count! + data.count!;
          tmpData.count = data.count!;
          isUpdated = true;
        }

        // 放入數組中
        String tmpDataStr = json.encode(tmpData.toJson());
        tmpList.add(tmpDataStr);
        models.add(tmpData);
      }

      if (!isUpdated) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }

      // 存入緩存
      prefs.setStringList("cartInfo", tmpList);
      notifyListeners();
    }
  }

  // 獲取購物車商品數量
  int getAllCount() {
    int count = 0;
    for (var model in models) {
      count += model.count!;
    }
    return count;
  }
}
