class OrderDetailModel {
  List<OrderDetailData>? orderDetailData;
  bool? isSuccess;
  String? message;

  OrderDetailModel({this.orderDetailData, this.isSuccess, this.message});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      orderDetailData = <OrderDetailData>[];
      json['Data'].forEach((v) {
        orderDetailData!.add(new OrderDetailData.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetailData != null) {
      data['Data'] = this.orderDetailData!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    return data;
  }
}

class OrderDetailData {
  List<Orders>? orders;
  List<OtherDetail>? otherDetail;
  List<ShippingDetail>? shippingDetail;

  OrderDetailData({this.orders, this.otherDetail, this.shippingDetail});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    if (json['Orders'] != null) {
      orders = <Orders>[];
      json['Orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    if (json['OtherDetail'] != null) {
      otherDetail = <OtherDetail>[];
      json['OtherDetail'].forEach((v) {
        otherDetail!.add(new OtherDetail.fromJson(v));
      });
    }
    if (json['ShippingDetail'] != null) {
      shippingDetail = <ShippingDetail>[];
      json['ShippingDetail'].forEach((v) {
        shippingDetail!.add(new ShippingDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['Orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.otherDetail != null) {
      data['OtherDetail'] = this.otherDetail!.map((v) => v.toJson()).toList();
    }
    if (this.shippingDetail != null) {
      data['ShippingDetail'] =
          this.shippingDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? orderdetailId;
  String? orderIdReference;
  String? productId;
  String? productdetailId;
  String? orderdetailProductSrp;
  String? orderdetailProductMrp;
  String? orderdetailQty;
  String? orderdetailUnit;
  String? orderdetailGst;
  String? orderdetailBatch;
  String? orderdetailExpDate;
  bool? orderdetailReturnStatus;
  String? orderdetailStatus;
  String? orderdetailCDT;
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

  Orders(
      {this.orderdetailId,
        this.orderIdReference,
        this.productId,
        this.productdetailId,
        this.orderdetailProductSrp,
        this.orderdetailProductMrp,
        this.orderdetailQty,
        this.orderdetailUnit,
        this.orderdetailGst,
        this.orderdetailBatch,
        this.orderdetailExpDate,
        this.orderdetailReturnStatus,
        this.orderdetailStatus,
        this.orderdetailCDT,
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

  Orders.fromJson(Map<String, dynamic> json) {
    orderdetailId = json['OrderdetailId'];
    orderIdReference = json['OrderIdReference'];
    productId = json['ProductId'];
    productdetailId = json['ProductdetailId'];
    orderdetailProductSrp = json['OrderdetailProductSrp'];
    orderdetailProductMrp = json['OrderdetailProductMrp'];
    orderdetailQty = json['OrderdetailQty'];
    orderdetailUnit = json['OrderdetailUnit'];
    orderdetailGst = json['OrderdetailGst'];
    orderdetailBatch = json['OrderdetailBatch'];
    orderdetailExpDate = json['OrderdetailExpDate'];
    orderdetailReturnStatus = json['OrderdetailReturnStatus'];
    orderdetailStatus = json['OrderdetailStatus'];
    orderdetailCDT = json['OrderdetailCDT'];
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
    data['OrderdetailId'] = this.orderdetailId;
    data['OrderIdReference'] = this.orderIdReference;
    data['ProductId'] = this.productId;
    data['ProductdetailId'] = this.productdetailId;
    data['OrderdetailProductSrp'] = this.orderdetailProductSrp;
    data['OrderdetailProductMrp'] = this.orderdetailProductMrp;
    data['OrderdetailQty'] = this.orderdetailQty;
    data['OrderdetailUnit'] = this.orderdetailUnit;
    data['OrderdetailGst'] = this.orderdetailGst;
    data['OrderdetailBatch'] = this.orderdetailBatch;
    data['OrderdetailExpDate'] = this.orderdetailExpDate;
    data['OrderdetailReturnStatus'] = this.orderdetailReturnStatus;
    data['OrderdetailStatus'] = this.orderdetailStatus;
    data['OrderdetailCDT'] = this.orderdetailCDT;
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

class OtherDetail {
  String? orderId;
  String? subTotal;
  String? orderStage;
  String? orderDate;
  String? orderDeliveryDate;
  String? deliveryCharge;
  String? earnedPoints;
  String? total;
  String? orderPaymentMethod;

  OtherDetail(
      {this.orderId,
        this.subTotal,
        this.orderStage,
        this.orderDate,
        this.orderDeliveryDate,
        this.deliveryCharge,
        this.earnedPoints,
        this.total,
        this.orderPaymentMethod});

  OtherDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    subTotal = json['SubTotal'];
    orderStage = json['OrderStage'];
    orderDate = json['OrderDate'];
    orderDeliveryDate = json['OrderDeliveryDate'];
    deliveryCharge = json['DeliveryCharge'];
    earnedPoints = json['EarnedPoints'];
    total = json['Total']?.toString(); // 👈 This line fixes the issue
    // total = json['Total'];
    orderPaymentMethod = json['OrderPaymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderId'] = this.orderId;
    data['SubTotal'] = this.subTotal;
    data['OrderStage'] = this.orderStage;
    data['OrderDate'] = this.orderDate;
    data['OrderDeliveryDate'] = this.orderDeliveryDate;
    data['DeliveryCharge'] = this.deliveryCharge;
    data['EarnedPoints'] = this.earnedPoints;
    data['Total'] = this.total;
    data['OrderPaymentMethod'] = this.orderPaymentMethod;
    return data;
  }
}

class ShippingDetail {
  String? addressFullName;
  String? addressColony;
  String? addressLandmark;
  String? city;
  String? state;
  String? pincode;

  ShippingDetail(
      {this.addressFullName,
        this.addressColony,
        this.addressLandmark,
        this.city,
        this.state,
        this.pincode});

  ShippingDetail.fromJson(Map<String, dynamic> json) {
    addressFullName = json['AddressFullName'];
    addressColony = json['AddressColony'];
    addressLandmark = json['AddressLandmark'];
    city = json['City'];
    state = json['State'];
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressFullName'] = this.addressFullName;
    data['AddressColony'] = this.addressColony;
    data['AddressLandmark'] = this.addressLandmark;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Pincode'] = this.pincode;
    return data;
  }
}