class SearchDropModel {
  final String? id;
  final String? title;
  final String? value;
  final String? price;
  SearchDropModel({this.title, this.value, this.id, this.price});

  factory SearchDropModel.fromJson(Map<String, dynamic> json) =>
      SearchDropModel(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "value": value,
        "price": price,
      };
}
