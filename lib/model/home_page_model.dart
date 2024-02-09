class HomePageModel {
  List<Swipers>? swipers;
  List<Logos>? logos;
  List<Quicks>? quicks;
  PageRow? pageRow;

  HomePageModel({this.swipers, this.logos, this.quicks, this.pageRow});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['swipers'] != null) {
      swipers = <Swipers>[];
      json['swipers'].forEach((v) {
        swipers!.add(Swipers.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(Logos.fromJson(v));
      });
    }
    if (json['quicks'] != null) {
      quicks = <Quicks>[];
      json['quicks'].forEach((v) {
        quicks!.add(Quicks.fromJson(v));
      });
    }
    pageRow =
        json['pageRow'] != null ? PageRow.fromJson(json['pageRow']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (swipers != null) {
      data['swipers'] = swipers!.map((v) => v.toJson()).toList();
    }
    if (logos != null) {
      data['logos'] = logos!.map((v) => v.toJson()).toList();
    }
    if (quicks != null) {
      data['quicks'] = quicks!.map((v) => v.toJson()).toList();
    }
    if (pageRow != null) {
      data['pageRow'] = pageRow!.toJson();
    }
    return data;
  }
}

class Swipers {
  String? image;

  Swipers({this.image});

  Swipers.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}

class Logos {
  String? image;
  String? title;

  Logos({this.image, this.title});

  Logos.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}

class Quicks {
  String? image;
  String? price;

  Quicks({this.image, this.price});

  Quicks.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}

class PageRow {
  List<String>? ad1;
  List<String>? ad2;

  PageRow({this.ad1, this.ad2});

  PageRow.fromJson(Map<String, dynamic> json) {
    ad1 = json['ad1'].cast<String>();
    ad2 = json['ad2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad1'] = ad1;
    data['ad2'] = ad2;
    return data;
  }
}
