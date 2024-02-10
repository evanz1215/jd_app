class CategoryContentModel {
  List<Data>? data;

  CategoryContentModel({this.data});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? title;
  List<Desc>? desc;

  Data({this.title, this.desc});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['desc'] != null) {
      desc = <Desc>[];
      json['desc'].forEach((v) {
        desc!.add(Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (desc != null) {
      data['desc'] = desc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  String? text;
  String? img;

  Desc({this.text, this.img});

  Desc.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['img'] = img;
    return data;
  }
}
