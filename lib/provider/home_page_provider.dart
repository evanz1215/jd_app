import 'package:flutter/foundation.dart';
import 'package:jd_app/config/jd_api.dart';
import 'package:jd_app/model/home_page_model.dart';
import 'package:jd_app/net/net_request.dart';

class HomePageProvider with ChangeNotifier {
  late HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadHomePageDate() {
    isLoading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(JdApi.HOME_PAGE).then((res) {
      isLoading = false;
      if (res.code == 200) {
        print(res.data);
        model = HomePageModel.fromJson(res.data);
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
