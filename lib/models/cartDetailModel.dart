class CartDetailModel {
  String? cartId;
  String? customerId;
  bool? isFav;
  String? productdetailId;
  String? productSize;
  String? productColor;
  List<PackInfo>? packInfo;
  String? cartQuantity;
  String? cartReturnStatus;
  String? cartOrder;
  String? cartOrderdetail;
  String? cartStatus;
  String? cartCDT;
  String? customerName;
  String? customerImage;
  String? customerEmailId;
  String? customerGender;
  String? customerFCMToken;
  String? customerPhoneNo;
  String? customerCode;
  String? customerReferCode;
  String? customerStatus;
  String? customerCDT;
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
  String? productIdReference;
  String? productdetailImages;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productdetailUnit;
  String? productdetailStatus;
  String? productdetailCDT;

  CartDetailModel(
      {this.cartId,
        this.customerId,
        this.isFav,
        this.productdetailId,
        this.productSize,
        this.productColor,
        this.packInfo,
        this.cartQuantity,
        this.cartReturnStatus,
        this.cartOrder,
        this.cartOrderdetail,
        this.cartStatus,
        this.cartCDT,
        this.customerName,
        this.customerImage,
        this.customerEmailId,
        this.customerGender,
        this.customerFCMToken,
        this.customerPhoneNo,
        this.customerCode,
        this.customerReferCode,
        this.customerStatus,
        this.customerCDT,
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
        this.productIdReference,
        this.productdetailImages,
        this.productdetailMrp,
        this.productdetailSrp,
        this.productdetailQty,
        this.productdetailUnit,
        this.productdetailStatus,
        this.productdetailCDT});

  CartDetailModel.fromJson(Map<String, dynamic> json) {
    cartId = json['CartId'];
    customerId = json['CustomerId'];
    isFav = json['isFav'];
    productdetailId = json['ProductdetailId'];
    productSize = json['ProductSize'];
    productColor = json['ProductColor'];
    if (json['PackInfo'] != null) {
      packInfo = <PackInfo>[];
      json['PackInfo'].forEach((v) {
        packInfo!.add(new PackInfo.fromJson(v));
      });
    }
    cartQuantity = json['CartQuantity'];
    cartReturnStatus = json['CartReturnStatus'];
    cartOrder = json['CartOrder'];
    cartOrderdetail = json['CartOrderdetail'];
    cartStatus = json['CartStatus'];
    cartCDT = json['CartCDT'];
    customerName = json['CustomerName'];
    customerImage = json['CustomerImage'];
    customerEmailId = json['CustomerEmailId'];
    customerGender = json['CustomerGender'];
    customerFCMToken = json['CustomerFCMToken'];
    customerPhoneNo = json['CustomerPhoneNo'];
    customerCode = json['CustomerCode'];
    customerReferCode = json['CustomerReferCode'];
    customerStatus = json['CustomerStatus'];
    customerCDT = json['CustomerCDT'];
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
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'];
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    productdetailQty = json['ProductdetailQty'];
    productdetailUnit = json['ProductdetailUnit'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CartId'] = this.cartId;
    data['CustomerId'] = this.customerId;
    data['isFav'] = this.isFav;
    data['ProductdetailId'] = this.productdetailId;
    data['ProductSize'] = this.productSize;
    data['ProductColor'] = this.productColor;
    if (this.packInfo != null) {
      data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
    }
    data['CartQuantity'] = this.cartQuantity;
    data['CartReturnStatus'] = this.cartReturnStatus;
    data['CartOrder'] = this.cartOrder;
    data['CartOrderdetail'] = this.cartOrderdetail;
    data['CartStatus'] = this.cartStatus;
    data['CartCDT'] = this.cartCDT;
    data['CustomerName'] = this.customerName;
    data['CustomerImage'] = this.customerImage;
    data['CustomerEmailId'] = this.customerEmailId;
    data['CustomerGender'] = this.customerGender;
    data['CustomerFCMToken'] = this.customerFCMToken;
    data['CustomerPhoneNo'] = this.customerPhoneNo;
    data['CustomerCode'] = this.customerCode;
    data['CustomerReferCode'] = this.customerReferCode;
    data['CustomerStatus'] = this.customerStatus;
    data['CustomerCDT'] = this.customerCDT;
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

class PackInfo {
  String? productdetailId;
  String? productIdReference;
  List<String>? productdetailImages;
  List<String>? color;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productdetailUnit;
  String? productdetailStatus;
  String? productdetailCDT;
  String? productColor;
  String? productSize;
  List<String>? size;

  PackInfo(
      {this.productdetailId,
        this.productIdReference,
        this.productdetailImages,
        this.color,
        this.size,
        this.productSize,
        this.productColor,
        this.productdetailMrp,
        this.productdetailSrp,
        this.productdetailQty,
        this.productdetailUnit,
        this.productdetailStatus,
        this.productdetailCDT});

  PackInfo.fromJson(Map<String, dynamic> json) {
    productdetailId = json['ProductdetailId'];
    productIdReference = json['ProductIdReference'];
    // productdetailImages = json['ProductdetailImages'];
    productdetailImages = (json['ProductdetailImages'] as List?)?.map((e) => e.toString()).toList();
    color = (json['Color'] as List?)?.map((e) => e.toString()).toList();
    size = (json['Size'] as List?)?.map((e) => e.toString()).toList();


    // color = json['Color'];
    // size = json['Size'];
    productColor = json['ProductColor'];
    productSize = json['ProductSize'];
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
    data['ProductIdReference'] = this.productIdReference;
    // data['ProductdetailImages'] = this.productdetailImages;
    data['Color'] = this.color;
    data['Size'] = this.size;
    data['ProductdetailImages'] = this.productdetailImages;

    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    data['ProductColor'] = this.productColor;
    data['ProductSize'] = this.productSize;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductdetailUnit'] = this.productdetailUnit;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    return data;
  }
}