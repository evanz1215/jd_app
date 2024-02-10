class CategoryContentModel {
  String? title;
  List<Desc>? desc;

  CategoryContentModel({this.title, this.desc});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
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
