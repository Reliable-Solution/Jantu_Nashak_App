class SubCategory {
  String? subcategoryId;
  String? categoryId;
  String? subcategoryName;
  String? subcategoryImage;
  String? subcategoryDesc;
  String? subcategoryStatus;
  String? subcategoryCDT;
  String? categoryName;
  String? categoryHindiName;
  String? categoryImage;
  String? categoryStatus;
  String? categoryCDT;

  SubCategory(
      {this.subcategoryId,
      this.categoryId,
      this.subcategoryName,
      this.subcategoryImage,
      this.subcategoryDesc,
      this.subcategoryStatus,
      this.subcategoryCDT,
      this.categoryName,
      this.categoryHindiName,
      this.categoryImage,
      this.categoryStatus,
      this.categoryCDT});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subcategoryId = json['SubcategoryId'];
    categoryId = json['CategoryId'];
    subcategoryName = json['SubcategoryName'];
    subcategoryImage = json['SubcategoryImage'];
    subcategoryDesc = json['SubcategoryDesc'];
    subcategoryStatus = json['SubcategoryStatus'];
    subcategoryCDT = json['SubcategoryCDT'];
    categoryName = json['CategoryName'];
    categoryHindiName = json['CategoryHindiName'];
    categoryImage = json['CategoryImage'];
    categoryStatus = json['CategoryStatus'];
    categoryCDT = json['CategoryCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubcategoryId'] = this.subcategoryId;
    data['CategoryId'] = this.categoryId;
    data['SubcategoryName'] = this.subcategoryName;
    data['SubcategoryImage'] = this.subcategoryImage;
    data['SubcategoryDesc'] = this.subcategoryDesc;
    data['SubcategoryStatus'] = this.subcategoryStatus;
    data['SubcategoryCDT'] = this.subcategoryCDT;
    data['CategoryName'] = this.categoryName;
    data['CategoryHindiName'] = this.categoryHindiName;
    data['CategoryImage'] = this.categoryImage;
    data['CategoryStatus'] = this.categoryStatus;
    data['CategoryCDT'] = this.categoryCDT;
    return data;
  }
}
