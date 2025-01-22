class Products {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  double? rate;
  List<String>? details;
  bool? isFavorite;

  Products({
    this.id,
    this.name,
    this.imageUrl,
    this.details,
    this.price,
    this.rate,
    this.isFavorite,
  });
}
