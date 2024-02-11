class ProductInfoModel {
  String? id;
  String? cover;
  String? title;
  String? price;
  String? comment;
  String? rate;

  ProductInfoModel(
      {this.id, this.cover, this.title, this.price, this.comment, this.rate});

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    price = json['price'];
    comment = json['comment'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cover'] = cover;
    data['title'] = title;
    data['price'] = price;
    data['comment'] = comment;
    data['rate'] = rate;
    return data;
  }
}
