class SearchModel {
  String? productId;
  bool? isFav;
  List<PackInfo>? packInfo;
  String? categoryId;
  String? subcategoryId;
  String? productName;
  String? brandId;
  String? hsnId;
  String? productSKU;
  String? productDescription;
  String? productKeyFeatures;
  String? productFeaturedYesNoRadio;
  String? productOrderByPrescriptionYesNoRadio;
  String? productType;
  String? productGst;
  String? productOfferCode;
  String? productStatus;
  String? productCDT;
  String? categoryName;
  String? categoryHindiName;
  String? categoryImage;
  String? categoryStatus;
  String? categoryCDT;
  String? subcategoryName;
  String? subcategoryImage;
  String? subcategoryDesc;
  String? subcategoryStatus;
  String? subcategoryCDT;
  String? brandName;
  String? brandDescription;
  String? brandImage;
  String? brandStatus;
  String? brandCDT;
  String? hsnName;
  String? hsnTax;
  String? hsnStatus;
  String? hsnCDT;

  SearchModel(
      {this.productId,
        this.isFav,
        this.packInfo,
        this.categoryId,
        this.subcategoryId,
        this.productName,
        this.brandId,
        this.hsnId,
        this.productSKU,
        this.productDescription,
        this.productKeyFeatures,
        this.productFeaturedYesNoRadio,
        this.productOrderByPrescriptionYesNoRadio,
        this.productType,
        this.productGst,
        this.productOfferCode,
        this.productStatus,
        this.productCDT,
        this.categoryName,
        this.categoryHindiName,
        this.categoryImage,
        this.categoryStatus,
        this.categoryCDT,
        this.subcategoryName,
        this.subcategoryImage,
        this.subcategoryDesc,
        this.subcategoryStatus,
        this.subcategoryCDT,
        this.brandName,
        this.brandDescription,
        this.brandImage,
        this.brandStatus,
        this.brandCDT,
        this.hsnName,
        this.hsnTax,
        this.hsnStatus,
        this.hsnCDT});

  SearchModel.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    isFav = json['isFav'];
    if (json['PackInfo'] != null) {
      packInfo = <PackInfo>[];
      json['PackInfo'].forEach((v) {
        packInfo!.add(new PackInfo.fromJson(v));
      });
    }
    categoryId = json['CategoryId'];
    subcategoryId = json['SubcategoryId'];
    productName = json['ProductName'];
    brandId = json['BrandId'];
    hsnId = json['HsnId'];
    productSKU = json['ProductSKU'];
    productDescription = json['ProductDescription'];
    productKeyFeatures = json['ProductKeyFeatures'];
    productFeaturedYesNoRadio = json['ProductFeaturedYesNoRadio'];
    productOrderByPrescriptionYesNoRadio =
    json['ProductOrderByPrescriptionYesNoRadio'];
    productType = json['ProductType'];
    productGst = json['ProductGst'];
    productOfferCode = json['ProductOfferCode'];
    productStatus = json['ProductStatus'];
    productCDT = json['ProductCDT'];
    categoryName = json['CategoryName'];
    categoryHindiName = json['CategoryHindiName'];
    categoryImage = json['CategoryImage'];
    categoryStatus = json['CategoryStatus'];
    categoryCDT = json['CategoryCDT'];
    subcategoryName = json['SubcategoryName'];
    subcategoryImage = json['SubcategoryImage'];
    subcategoryDesc = json['SubcategoryDesc'];
    subcategoryStatus = json['SubcategoryStatus'];
    subcategoryCDT = json['SubcategoryCDT'];
    brandName = json['BrandName'];
    brandDescription = json['BrandDescription'];
    brandImage = json['BrandImage'];
    brandStatus = json['BrandStatus'];
    brandCDT = json['BrandCDT'];
    hsnName = json['HsnName'];
    hsnTax = json['HsnTax'];
    hsnStatus = json['HsnStatus'];
    hsnCDT = json['HsnCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['isFav'] = this.isFav;
    if (this.packInfo != null) {
      data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
    }
    data['CategoryId'] = this.categoryId;
    data['SubcategoryId'] = this.subcategoryId;
    data['ProductName'] = this.productName;
    data['BrandId'] = this.brandId;
    data['HsnId'] = this.hsnId;
    data['ProductSKU'] = this.productSKU;
    data['ProductDescription'] = this.productDescription;
    data['ProductKeyFeatures'] = this.productKeyFeatures;
    data['ProductFeaturedYesNoRadio'] = this.productFeaturedYesNoRadio;
    data['ProductOrderByPrescriptionYesNoRadio'] =
        this.productOrderByPrescriptionYesNoRadio;
    data['ProductType'] = this.productType;
    data['ProductGst'] = this.productGst;
    data['ProductOfferCode'] = this.productOfferCode;
    data['ProductStatus'] = this.productStatus;
    data['ProductCDT'] = this.productCDT;
    data['CategoryName'] = this.categoryName;
    data['CategoryHindiName'] = this.categoryHindiName;
    data['CategoryImage'] = this.categoryImage;
    data['CategoryStatus'] = this.categoryStatus;
    data['CategoryCDT'] = this.categoryCDT;
    data['SubcategoryName'] = this.subcategoryName;
    data['SubcategoryImage'] = this.subcategoryImage;
    data['SubcategoryDesc'] = this.subcategoryDesc;
    data['SubcategoryStatus'] = this.subcategoryStatus;
    data['SubcategoryCDT'] = this.subcategoryCDT;
    data['BrandName'] = this.brandName;
    data['BrandDescription'] = this.brandDescription;
    data['BrandImage'] = this.brandImage;
    data['BrandStatus'] = this.brandStatus;
    data['BrandCDT'] = this.brandCDT;
    data['HsnName'] = this.hsnName;
    data['HsnTax'] = this.hsnTax;
    data['HsnStatus'] = this.hsnStatus;
    data['HsnCDT'] = this.hsnCDT;
    return data;
  }
}

class PackInfo {
  String? productdetailId;
  bool? isCart;
  int? cartqty;
  String? productIdReference;
  List<String>? productdetailImages;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productdetailUnit;
  String? productdetailStatus;
  String? productdetailCDT;

  PackInfo(
      {this.productdetailId,
        this.isCart,
        this.cartqty,
        this.productIdReference,
        this.productdetailImages,
        this.productdetailMrp,
        this.productdetailSrp,
        this.productdetailQty,
        this.productdetailUnit,
        this.productdetailStatus,
        this.productdetailCDT});

  PackInfo.fromJson(Map<String, dynamic> json) {
    productdetailId = json['ProductdetailId'];
    isCart = json['isCart'];
    cartqty = json['Cartqty'];
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'].cast<String>();
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    productdetailQty = json['ProductdetailQty'];
    productdetailUnit = json['ProductdetailUnit'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductdetailId'] = this.productdetailId;
    data['isCart'] = this.isCart;
    data['Cartqty'] = this.cartqty;
    data['ProductIdReference'] = this.productIdReference;
    data['ProductdetailImages'] = this.productdetailImages;
    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductdetailUnit'] = this.productdetailUnit;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    return data;
  }
}