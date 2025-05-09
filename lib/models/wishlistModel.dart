
import 'package:keep_app/models/productModel.dart';

class WishlistModel {
  String? wishlistId;
  String? wishlistName;
  String? customerId;
  String? productId;
  bool? isFav;
  List<PackInfo>? packInfo;
  String? wishlistStatus;
  String? wishlistCDT;
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

  WishlistModel(
      {this.wishlistId,
        this.wishlistName,
        this.customerId,
        this.productId,
        this.isFav,
        required this.packInfo,
        this.wishlistStatus,
        this.wishlistCDT,
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
        this.productCDT});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    wishlistId = json['WishlistId'];
    wishlistName = json['WishlistName'];
    customerId = json['CustomerId'];
    productId = json['ProductId'];
    isFav = json['isFav'];
    if (json['PackInfo'] != null) {
      packInfo = <PackInfo>[];
      json['PackInfo'].forEach((v) {
        packInfo!.add(new PackInfo.fromJson(v));
      });
    }
    wishlistStatus = json['WishlistStatus'];
    wishlistCDT = json['WishlistCDT'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WishlistId'] = this.wishlistId;
    data['WishlistName'] = this.wishlistName;
    data['CustomerId'] = this.customerId;
    data['ProductId'] = this.productId;
    data['isFav'] = this.isFav;
    if (this.packInfo != null) {
      data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
    }
    data['WishlistStatus'] = this.wishlistStatus;
    data['WishlistCDT'] = this.wishlistCDT;
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
    return data;
  }
}

