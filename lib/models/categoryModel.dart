class Category {
  final String categoryId;
  final String categoryName;
  final String categoryHindiName;
  final String categoryImage;
  final String categoryStatus;
  final String categoryCDT;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryHindiName,
    required this.categoryImage,
    required this.categoryStatus,
    required this.categoryCDT,
  });

  // Factory method to parse JSON data into a Category object
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
      categoryHindiName: json['CategoryHindiName'],
      categoryImage: json['CategoryImage'],
      categoryStatus: json['CategoryStatus'],
      categoryCDT: json['CategoryCDT'],
    );
  }
}
