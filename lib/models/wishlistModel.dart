class Wishlist {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  double? rate;
  List<String>? details;
  bool? isFavorite;

  Wishlist({
    this.id,
    this.name,
    this.imageUrl,
    this.details,
    this.price,
    this.rate,
    this.isFavorite,
  });
}
