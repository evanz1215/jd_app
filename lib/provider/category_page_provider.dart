import 'package:flutter/foundation.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/category_content_model.dart';
import 'package:jd_app/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  loadCategoryPageData() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(JdApi.CATEGORY_NAV).then((res) {
      isLoading = false;
      // print(res.data);
      if (res.data is List) {
        // 在建立新的List可以使用
        categoryNavList = List<String>.from(res.data);

        // 在原有List上添加新的item可以使用
        // for (var i = 0; i < res.data.length; i++) {
        //   categoryNavList.add(res.data[i]);
        // }

        loadCategoryContentData(tabIndex);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  // 加載分類內容數據
  loadCategoryContentData(int index) {
    tabIndex = index;
    // print(index);
    isLoading = true;
    isError = false;
    errorMsg = "";
    categoryContentList.clear();

    var data = {"title": categoryNavList[index]};

    NetRequest()
        .requestData(JdApi.CATEGORY_CONTENT, data: data, method: "post")
        .then((res) {
      isLoading = false;
      // print(res.data);
      if (res.data is List) {
        for (var item in res.data) {
          CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
          categoryContentList.add(tmpModel);
        }
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });

    notifyListeners();
  }
}
