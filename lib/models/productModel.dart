class ProductModel {
  String? productId;
  bool? isFav;
  List<PackInfo>? packInfo;
  // List<String>? size;
  // List<String>? color;
  List<String>? qty;
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
  String? subcategoryName;
  String? subcategoryImage;
  String? subcategoryDesc;
  String? subcategoryStatus;
  String? subcategoryCDT;

  ProductModel(
      {this.productId,
      this.isFav,
      this.packInfo,
      // this.size,
      // this.color,
      this.qty,
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
      this.subcategoryName,
      this.subcategoryImage,
      this.subcategoryDesc,
      this.subcategoryStatus,
      this.subcategoryCDT});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
    // size = json['Size'].cast<String>();
    // color = json['Color'].cast<String>();
    qty = json['QTY'].cast<String>();
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
    subcategoryName = json['SubcategoryName'];
    subcategoryImage = json['SubcategoryImage'];
    subcategoryDesc = json['SubcategoryDesc'];
    subcategoryStatus = json['SubcategoryStatus'];
    subcategoryCDT = json['SubcategoryCDT'];
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
    // data['Size'] = this.size;
    // data['Color'] = this.color;
    data['QTY'] = this.qty;
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
    data['SubcategoryName'] = this.subcategoryName;
    data['SubcategoryImage'] = this.subcategoryImage;
    data['SubcategoryDesc'] = this.subcategoryDesc;
    data['SubcategoryStatus'] = this.subcategoryStatus;
    data['SubcategoryCDT'] = this.subcategoryCDT;
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
  // String? productColor;
  // String? productSize;
  String? productQty;
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
      // this.productColor,
      // this.productSize,
      this.productQty,
      this.productdetailQty,
      this.productdetailUnit,
      this.productdetailStatus,
      this.productdetailCDT});

  PackInfo.fromJson(Map<String, dynamic> json) {
    productdetailId = json['ProductdetailId'];
    isCart = json['isCart'];
    cartqty = json['Cartqty']?.toString();
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'].cast<String>();
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    // productColor = json['ProductColor'];
    // productSize = json['ProductSize'];
    productQty = json['ProductQTY'];
    productdetailQty = json['ProductdetailQty'];
    productdetailUnit = json['ProductdetailUnit'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductdetailId'] = this.productdetailId;
    data['isCart'] = this.isCart;
    data['Cartqty'] = this.cartqty?.toString();
    data['ProductIdReference'] = this.productIdReference;
    data['ProductdetailImages'] = this.productdetailImages;
    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    // data['ProductColor'] = this.productColor;
    // data['ProductSize'] = this.productSize;
    data['ProductQTY'] = this.productQty;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductdetailUnit'] = this.productdetailUnit;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    return data;
  }
}
