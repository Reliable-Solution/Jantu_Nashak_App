class EducationModel {
  bool? isSuccess;
  String? message;
  List<EducationData>? data;

  EducationModel({this.isSuccess, this.message, this.data});

  EducationModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['EducationData'] != null) {
      data = <EducationData>[];
      json['EducationData'].forEach((v) {
        data!.add(new EducationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.data != null) {
      data['EducationData'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EducationData {
  String? educationalCategoryId;
  String? educationalCategoryName;
  String? educationalCategoryGujaratiName;
  String? educationalCategoryImage;
  String? firmId;
  String? educationalcategoryStatus;
  String? educationalcategoryCDT;
  List<Blogs>? blogs;

  EducationData(
      {this.educationalCategoryId,
      this.educationalCategoryName,
      this.educationalCategoryGujaratiName,
      this.educationalCategoryImage,
      this.firmId,
      this.educationalcategoryStatus,
      this.educationalcategoryCDT,
      this.blogs});

  EducationData.fromJson(Map<String, dynamic> json) {
    educationalCategoryId = json['EducationalCategoryId'];
    educationalCategoryName = json['EducationalCategoryName'];
    educationalCategoryGujaratiName = json['EducationalCategoryGujaratiName'];
    educationalCategoryImage = json['EducationalCategoryImage'];
    firmId = json['FirmId'];
    educationalcategoryStatus = json['EducationalcategoryStatus'];
    educationalcategoryCDT = json['EducationalcategoryCDT'];
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EducationalCategoryId'] = this.educationalCategoryId;
    data['EducationalCategoryName'] = this.educationalCategoryName;
    data['EducationalCategoryGujaratiName'] =
        this.educationalCategoryGujaratiName;
    data['EducationalCategoryImage'] = this.educationalCategoryImage;
    data['FirmId'] = this.firmId;
    data['EducationalcategoryStatus'] = this.educationalcategoryStatus;
    data['EducationalcategoryCDT'] = this.educationalcategoryCDT;
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  String? blogId;
  String? educationalCategoryId;
  String? blogTitle;
  String? blogLink;
  String? blogDescription;
  String? blogImage;
  String? blogStatus;
  String? blogCDT;
  String? educationalCategoryName;
  String? educationalCategoryGujaratiName;
  String? educationalCategoryImage;
  String? firmId;
  String? educationalcategoryStatus;
  String? educationalcategoryCDT;
  String? productId;

  List<Products>? products;

  Blogs(
      {this.blogId,
      this.educationalCategoryId,
      this.blogTitle,
      this.blogLink,
      this.blogDescription,
      this.blogImage,
      this.blogStatus,
      this.blogCDT,
      this.educationalCategoryName,
      this.educationalCategoryGujaratiName,
      this.educationalCategoryImage,
      this.firmId,
      this.educationalcategoryStatus,
      this.educationalcategoryCDT,
      this.productId,
      this.products});

  Blogs.fromJson(Map<String, dynamic> json) {
    blogId = json['BlogId'];
    educationalCategoryId = json['EducationalCategoryId'];
    blogTitle = json['BlogTitle'];
    blogLink = json['BlogLink'];
    blogDescription = json['BlogDescription'];
    blogImage = json['BlogImage'];
    blogStatus = json['BlogStatus'];
    blogCDT = json['BlogCDT'];
    educationalCategoryName = json['EducationalCategoryName'];
    educationalCategoryGujaratiName = json['EducationalCategoryGujaratiName'];
    educationalCategoryImage = json['EducationalCategoryImage'];
    firmId = json['FirmId'];
    educationalcategoryStatus = json['EducationalcategoryStatus'];
    educationalcategoryCDT = json['EducationalcategoryCDT'];
    productId = json['ProductId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BlogId'] = this.blogId;
    data['EducationalCategoryId'] = this.educationalCategoryId;
    data['BlogTitle'] = this.blogTitle;
    data['BlogLink'] = this.blogLink;
    data['BlogDescription'] = this.blogDescription;
    data['BlogImage'] = this.blogImage;
    data['BlogStatus'] = this.blogStatus;
    data['BlogCDT'] = this.blogCDT;
    data['EducationalCategoryName'] = this.educationalCategoryName;
    data['EducationalCategoryGujaratiName'] =
        this.educationalCategoryGujaratiName;
    data['EducationalCategoryImage'] = this.educationalCategoryImage;
    data['FirmId'] = this.firmId;
    data['EducationalcategoryStatus'] = this.educationalcategoryStatus;
    data['EducationalcategoryCDT'] = this.educationalcategoryCDT;
    data['ProductId'] = this.productId;

    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
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
  List<PackInfo>? packInfo;
  List<String>? qTY;
  String? productdetailId;
  String? productIdReference;
  String? productdetailImages;
  String? productdetailMrp;
  String? productdetailSrp;
  String? productdetailQty;
  String? productQTY;
  String? productdetailStatus;
  String? productdetailCDT;
  bool? isFav;

  Products(
      {this.productId,
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
      this.packInfo,
      this.qTY,
      this.productdetailId,
      this.productIdReference,
      this.productdetailImages,
      this.productdetailMrp,
      this.productdetailSrp,
      this.productdetailQty,
      this.productQTY,
      this.productdetailStatus,
      this.productdetailCDT,
      this.isFav});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
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
    if (json['PackInfo'] != null) {
      packInfo = <PackInfo>[];
      json['PackInfo'].forEach((v) {
        packInfo!.add(new PackInfo.fromJson(v));
      });
    }
    qTY = json['QTY'].cast<String>();
    productdetailId = json['ProductdetailId'];
    productIdReference = json['ProductIdReference'];
    productdetailImages = json['ProductdetailImages'];
    productdetailMrp = json['ProductdetailMrp'];
    productdetailSrp = json['ProductdetailSrp'];
    productdetailQty = json['ProductdetailQty'];
    productQTY = json['ProductQTY'];
    productdetailStatus = json['ProductdetailStatus'];
    productdetailCDT = json['ProductdetailCDT'];
    isFav = json['isFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
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
    if (this.packInfo != null) {
      data['PackInfo'] = this.packInfo!.map((v) => v.toJson()).toList();
    }
    data['QTY'] = this.qTY;
    data['ProductdetailId'] = this.productdetailId;
    data['ProductIdReference'] = this.productIdReference;
    data['ProductdetailImages'] = this.productdetailImages;
    data['ProductdetailMrp'] = this.productdetailMrp;
    data['ProductdetailSrp'] = this.productdetailSrp;
    data['ProductdetailQty'] = this.productdetailQty;
    data['ProductQTY'] = this.productQTY;
    data['ProductdetailStatus'] = this.productdetailStatus;
    data['ProductdetailCDT'] = this.productdetailCDT;
    data['isFav'] = this.isFav;
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
    cartqty = json['Cartqty'];
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
    data['Cartqty'] = this.cartqty;
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
