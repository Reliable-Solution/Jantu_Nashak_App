class TagModel {
  String? tagId;
  String? tagName;
  String? tagImage;
  String? languageId;
  String? tagStatus;
  String? tagCDT;
  String? languageName;
  String? languageStatus;
  String? languageCDT;
  List<Products>? products;

  TagModel(
      {this.tagId,
      this.tagName,
      this.tagImage,
      this.languageId,
      this.tagStatus,
      this.tagCDT,
      this.languageName,
      this.languageStatus,
      this.languageCDT,
      this.products});

  TagModel.fromJson(Map<String, dynamic> json) {
    tagId = json['TagId'];
    tagName = json['TagName'];
    tagImage = json['TagImage'];
    languageId = json['LanguageId'];
    tagStatus = json['TagStatus'];
    tagCDT = json['TagCDT'];
    languageName = json['LanguageName'];
    languageStatus = json['LanguageStatus'];
    languageCDT = json['LanguageCDT'];
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TagId'] = this.tagId;
    data['TagName'] = this.tagName;
    data['TagImage'] = this.tagImage;
    data['LanguageId'] = this.languageId;
    data['TagStatus'] = this.tagStatus;
    data['TagCDT'] = this.tagCDT;
    data['LanguageName'] = this.languageName;
    data['LanguageStatus'] = this.languageStatus;
    data['LanguageCDT'] = this.languageCDT;
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  bool? isFav;
  List<PackInfo>? packInfo;
  List<String>? qTY;
  String? firmId;
  String? categoryId;
  String? subcategoryId;
  String? tagId;
  String? productName;
  String? brandId;
  String? hsnId;
  String? productSKU;
  String? productDescription;
  String? productKeyFeatures;
  String? productFeaturedYesNoRadio;
  String? productType;
  String? productGst;
  String? productOfferCode;
  String? productStatus;
  String? productCDT;
  String? productdetailId;
  String? productIdReference;
  String? productdetailImages;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productQTY;
  String? productdetailStatus;
  String? productdetailCDT;

  Products(
      {this.productId,
      this.isFav,
      this.packInfo,
      this.qTY,
      this.firmId,
      this.categoryId,
      this.subcategoryId,
      this.tagId,
      this.productName,
      this.brandId,
      this.hsnId,
      this.productSKU,
      this.productDescription,
      this.productKeyFeatures,
      this.productFeaturedYesNoRadio,
      this.productType,
      this.productGst,
      this.productOfferCode,
      this.productStatus,
      this.productCDT,
      this.productdetailId,
      this.productIdReference,
      this.productdetailImages,
      this.productdetailMrp,
      this.productdetailSrp,
      this.productdetailQty,
      this.productQTY,
      this.productdetailStatus,
      this.productdetailCDT});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    isFav = json['isFav'];
    if (json['PackInfo'] != null) {
      packInfo = <PackInfo>[];
      json['PackInfo'].forEach((v) {
        packInfo!.add(new PackInfo.fromJson(v));
      });
    }
    qTY = json['QTY'].cast<String>();
    firmId = json['FirmId'];
    categoryId = json['CategoryId'];
    subcategoryId = json['SubcategoryId'];
    tagId = json['TagId'];
    productName = json['ProductName'];
    brandId = json['BrandId'];
    hsnId = json['HsnId'];
    productSKU = json['ProductSKU'];
    productDescription = json['ProductDescription'];
    productKeyFeatures = json['ProductKeyFeatures'];
    productFeaturedYesNoRadio = json['ProductFeaturedYesNoRadio'];
    productType = json['ProductType'];
    productGst = json['ProductGst'];
    productOfferCode = json['ProductOfferCode'];
    productStatus = json['ProductStatus'];
    productCDT = json['ProductCDT'];
    productdetailId = json['ProductdetailId'];
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'];
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    productdetailQty = json['ProductdetailQty'];
    productQTY = json['ProductQTY'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['isFav'] = this.isFav;
    if (this.packInfo != null) {
      data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
    }
    data['QTY'] = this.qTY;
    data['FirmId'] = this.firmId;
    data['CategoryId'] = this.categoryId;
    data['SubcategoryId'] = this.subcategoryId;
    data['TagId'] = this.tagId;
    data['ProductName'] = this.productName;
    data['BrandId'] = this.brandId;
    data['HsnId'] = this.hsnId;
    data['ProductSKU'] = this.productSKU;
    data['ProductDescription'] = this.productDescription;
    data['ProductKeyFeatures'] = this.productKeyFeatures;
    data['ProductFeaturedYesNoRadio'] = this.productFeaturedYesNoRadio;
    data['ProductType'] = this.productType;
    data['ProductGst'] = this.productGst;
    data['ProductOfferCode'] = this.productOfferCode;
    data['ProductStatus'] = this.productStatus;
    data['ProductCDT'] = this.productCDT;
    data['ProductdetailId'] = this.productdetailId;
    data['ProductIdReference'] = this.productIdReference;
    data['ProductdetailImages'] = this.productdetailImages;
    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductQTY'] = this.productQTY;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    return data;
  }
}

class PackInfo {
  String? productdetailId;
  bool? isCart;
  String? cartqty;
  String? productIdReference;
  List<String>? productdetailImages;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productQTY;
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
      this.productQTY,
      this.productdetailStatus,
      this.productdetailCDT});

  PackInfo.fromJson(Map<String, dynamic> json) {
    productdetailId = json['ProductdetailId'];
    isCart = json['isCart'];
    cartqty = json['Cartqty'].toString();
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'].cast<String>();
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    productdetailQty = json['ProductdetailQty'];
    productQTY = json['ProductQTY'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductdetailId'] = this.productdetailId;
    data['isCart'] = this.isCart;
    data['Cartqty'] = this.cartqty.toString();
    data['ProductIdReference'] = this.productIdReference;
    data['ProductdetailImages'] = this.productdetailImages;
    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductQTY'] = this.productQTY;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    return data;
  }
}
// class TagModel {
//   String? tagId;
//   String? tagName;
//   String? tagImage;
//   String? languageId;
//   String? tagStatus;
//   String? tagCDT;
//   String? languageName;
//   String? languageStatus;
//   String? languageCDT;
//   List<Products>? products;
//
//   TagModel(
//       {this.tagId,
//         this.tagName,
//         this.tagImage,
//         this.languageId,
//         this.tagStatus,
//         this.tagCDT,
//         this.languageName,
//         this.languageStatus,
//         this.languageCDT,
//         this.products});
//
//   TagModel.fromJson(Map<String, dynamic> json) {
//     tagId = json['TagId'];
//     tagName = json['TagName'];
//     tagImage = json['TagImage'];
//     languageId = json['LanguageId'];
//     tagStatus = json['TagStatus'];
//     tagCDT = json['TagCDT'];
//     languageName = json['LanguageName'];
//     languageStatus = json['LanguageStatus'];
//     languageCDT = json['LanguageCDT'];
//     if (json['Products'] != null) {
//       products = <Products>[];
//       json['Products'].forEach((v) {
//         products!.add(new Products.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TagId'] = this.tagId;
//     data['TagName'] = this.tagName;
//     data['TagImage'] = this.tagImage;
//     data['LanguageId'] = this.languageId;
//     data['TagStatus'] = this.tagStatus;
//     data['TagCDT'] = this.tagCDT;
//     data['LanguageName'] = this.languageName;
//     data['LanguageStatus'] = this.languageStatus;
//     data['LanguageCDT'] = this.languageCDT;
//     if (this.products != null) {
//       data['Products'] = this.products!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Products {
//   String? productId;
//   bool? isFav;
//   List<PackInfo>? packInfo;
//   List<String>? qTY;
//   String? firmId;
//   String? categoryId;
//   String? subcategoryId;
//   String? tagId;
//   String? productName;
//   String? brandId;
//   String? hsnId;
//   String? productSKU;
//   String? productDescription;
//   String? productKeyFeatures;
//   String? productFeaturedYesNoRadio;
//   String? productType;
//   String? productGst;
//   String? productOfferCode;
//   String? productStatus;
//   String? productCDT;
//   String? productdetailId;
//   String? productIdReference;
//   String? productdetailImages;
//   String? productdetailMrp;
//   String? productdetailSrp;
//   String? productdetailQty;
//   String? productQTY;
//   String? productdetailStatus;
//   String? productdetailCDT;
//
//   Products(
//       {this.productId,
//         this.isFav,
//         this.packInfo,
//         this.qTY,
//         this.firmId,
//         this.categoryId,
//         this.subcategoryId,
//         this.tagId,
//         this.productName,
//         this.brandId,
//         this.hsnId,
//         this.productSKU,
//         this.productDescription,
//         this.productKeyFeatures,
//         this.productFeaturedYesNoRadio,
//         this.productType,
//         this.productGst,
//         this.productOfferCode,
//         this.productStatus,
//         this.productCDT,
//         this.productdetailId,
//         this.productIdReference,
//         this.productdetailImages,
//         this.productdetailMrp,
//         this.productdetailSrp,
//         this.productdetailQty,
//         this.productQTY,
//         this.productdetailStatus,
//         this.productdetailCDT});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     productId = json['ProductId'];
//     isFav = json['isFav'];
//     if (json['PackInfo'] != null) {
//       packInfo = <PackInfo>[];
//       json['PackInfo'].forEach((v) {
//         packInfo!.add(new PackInfo.fromJson(v));
//       });
//     }
//     qTY = json['QTY'].cast<String>();
//     firmId = json['FirmId'];
//     categoryId = json['CategoryId'];
//     subcategoryId = json['SubcategoryId'];
//     tagId = json['TagId'];
//     productName = json['ProductName'];
//     brandId = json['BrandId'];
//     hsnId = json['HsnId'];
//     productSKU = json['ProductSKU'];
//     productDescription = json['ProductDescription'];
//     productKeyFeatures = json['ProductKeyFeatures'];
//     productFeaturedYesNoRadio = json['ProductFeaturedYesNoRadio'];
//     productType = json['ProductType'];
//     productGst = json['ProductGst'];
//     productOfferCode = json['ProductOfferCode'];
//     productStatus = json['ProductStatus'];
//     productCDT = json['ProductCDT'];
//     productdetailId = json['ProductdetailId'];
//     productIdReference = json['ProductIdReference'];
//     productdetailImages = json['ProductdetailImages'];
//     productdetailMrp = json['ProductdetailMrp'];
//     productdetailSrp = json['ProductdetailSrp'];
//     productdetailQty = json['ProductdetailQty'];
//     productQTY = json['ProductQTY'];
//     productdetailStatus = json['ProductdetailStatus'];
//     productdetailCDT = json['ProductdetailCDT'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ProductId'] = this.productId;
//     data['isFav'] = this.isFav;
//     if (this.packInfo != null) {
//       data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
//     }
//     data['QTY'] = this.qTY;
//     data['FirmId'] = this.firmId;
//     data['CategoryId'] = this.categoryId;
//     data['SubcategoryId'] = this.subcategoryId;
//     data['TagId'] = this.tagId;
//     data['ProductName'] = this.productName;
//     data['BrandId'] = this.brandId;
//     data['HsnId'] = this.hsnId;
//     data['ProductSKU'] = this.productSKU;
//     data['ProductDescription'] = this.productDescription;
//     data['ProductKeyFeatures'] = this.productKeyFeatures;
//     data['ProductFeaturedYesNoRadio'] = this.productFeaturedYesNoRadio;
//     data['ProductType'] = this.productType;
//     data['ProductGst'] = this.productGst;
//     data['ProductOfferCode'] = this.productOfferCode;
//     data['ProductStatus'] = this.productStatus;
//     data['ProductCDT'] = this.productCDT;
//     data['ProductdetailId'] = this.productdetailId;
//     data['ProductIdReference'] = this.productIdReference;
//     data['ProductdetailImages'] = this.productdetailImages;
//     data['ProductdetailMrp'] = this.productdetailMrp;
//     data['ProductdetailSrp'] = this.productdetailSrp;
//     data['ProductdetailQty'] = this.productdetailQty;
//     data['ProductQTY'] = this.productQTY;
//     data['ProductdetailStatus'] = this.productdetailStatus;
//     data['ProductdetailCDT'] = this.productdetailCDT;
//     return data;
//   }
// }
//
// class PackInfo {
//   String? productdetailId;
//   bool? isCart;
//   int? cartqty;
//   String? productIdReference;
//   List<String>? productdetailImages;
//   String? productdetailMrp;
//   String? productdetailSrp;
//   String? productdetailQty;
//   String? productQTY;
//   String? productdetailStatus;
//   String? productdetailCDT;
//
//   PackInfo(
//       {this.productdetailId,
//         this.isCart,
//         this.cartqty,
//         this.productIdReference,
//         this.productdetailImages,
//         this.productdetailMrp,
//         this.productdetailSrp,
//         this.productdetailQty,
//         this.productQTY,
//         this.productdetailStatus,
//         this.productdetailCDT});
//
//   PackInfo.fromJson(Map<String, dynamic> json) {
//     productdetailId = json['ProductdetailId'];
//     isCart = json['isCart'];
//     cartqty = json['Cartqty'];
//     productIdReference = json['ProductIdReference'];
//     productdetailImages = json['ProductdetailImages'].cast<String>();
//     productdetailMrp = json['ProductdetailMrp'];
//     productdetailSrp = json['ProductdetailSrp'];
//     productdetailQty = json['ProductdetailQty'];
//     productQTY = json['ProductQTY'];
//     productdetailStatus = json['ProductdetailStatus'];
//     productdetailCDT = json['ProductdetailCDT'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ProductdetailId'] = this.productdetailId;
//     data['isCart'] = this.isCart;
//     data['Cartqty'] = this.cartqty;
//     data['ProductIdReference'] = this.productIdReference;
//     data['ProductdetailImages'] = this.productdetailImages;
//     data['ProductdetailMrp'] = this.productdetailMrp;
//     data['ProductdetailSrp'] = this.productdetailSrp;
//     data['ProductdetailQty'] = this.productdetailQty;
//     data['ProductQTY'] = this.productQTY;
//     data['ProductdetailStatus'] = this.productdetailStatus;
//     data['ProductdetailCDT'] = this.productdetailCDT;
//     return data;
//   }
// }
//
