class HomeModel {
  String? image;
  String? title;
  String? describe;
  String? date;
  String? url;

  HomeModel({this.image, this.title, this.describe, this.date, this.url});

  HomeModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    describe = json['describe'];
    date = json['date'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['describe'] = this.describe;
    data['date'] = this.date;
    data['url'] = this.url;
    return data;
  }
}
