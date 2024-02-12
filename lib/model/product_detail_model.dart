class ProductDetailModel {
  PartData? partData;
  List<Baitiao>? baitiao;

  ProductDetailModel({this.partData, this.baitiao});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    partData =
        json['partData'] != null ? PartData.fromJson(json['partData']) : null;
    if (json['baitiao'] != null) {
      baitiao = <Baitiao>[];
      json['baitiao'].forEach((v) {
        baitiao!.add(Baitiao.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (partData != null) {
      data['partData'] = partData!.toJson();
    }
    if (baitiao != null) {
      data['baitiao'] = baitiao!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartData {
  String? id;
  List<String>? loopImgUrl;
  String? title;
  String? price;
  int? count;

  PartData({this.id, this.loopImgUrl, this.title, this.price, this.count});

  PartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loopImgUrl = json['loopImgUrl'].cast<String>();
    title = json['title'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['loopImgUrl'] = loopImgUrl;
    data['title'] = title;
    data['price'] = price;
    data['count'] = count;
    return data;
  }
}

class Baitiao {
  String? desc;
  String? tip;
  bool? select;

  Baitiao({this.desc, this.tip, this.select});

  Baitiao.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    tip = json['tip'];
    select = json['select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = desc;
    data['tip'] = tip;
    data['select'] = select;
    return data;
  }
}
