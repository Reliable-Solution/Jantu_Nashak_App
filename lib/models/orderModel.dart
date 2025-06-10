class OrderModel {
  List<OrderDataModel>? orderDataModel;
  bool? isSuccess;
  String? message;

  OrderModel({this.orderDataModel, this.isSuccess, this.message});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      orderDataModel = <OrderDataModel>[];
      json['Data'].forEach((v) {
        orderDataModel!.add(new OrderDataModel.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDataModel != null) {
      data['Data'] = this.orderDataModel!.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    return data;
  }
}

class OrderDataModel {
  String? orderId;
  String? firmId;
  String? customerId;
  String? addressId;
  String? ordertrackingLink;
  String? orderDoctorName;
  String? orderPaymentMethod;
  String? orderTransactionNo;
  String? orderStageDropDown;
  String? orderItemsProcessingDate;
  String? orderDeliveringDate;
  String? orderDeliveredDate;
  String? orderDeliveryDate;
  String? orderCancelDate;
  String? orderGST;
  String? orderSubTotal;
  String? orderPointsType;
  String? orderTotalPoints;
  String? orderTotal;
  String? orderShippingCharge;
  String? orderKey;
  String? orderMessage;
  String? orderDate;
  String? orderByPrescription;
  String? orderByPrescriptionImage;
  String? orderStatus;
  String? orderCDT;
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
  String? addressFullName;
  String? addressMobileNo;
  String? addressColony;
  String? addressLandmark;
  String? addressType;
  String? stateId;
  String? cityId;
  String? addressAlternativeNo;
  String? addressPincode;
  String? addressDefault;
  String? addressStatus;
  String? addressCDT;

  OrderDataModel(
      {this.orderId,
      this.firmId,
        this.customerId,
        this.addressId,
        this.ordertrackingLink,
        this.orderDoctorName,
        this.orderPaymentMethod,
        this.orderTransactionNo,
        this.orderStageDropDown,
        this.orderItemsProcessingDate,
        this.orderDeliveringDate,
        this.orderDeliveredDate,
        this.orderDeliveryDate,
        this.orderCancelDate,
        this.orderGST,
        this.orderSubTotal,
        this.orderPointsType,
        this.orderTotalPoints,
        this.orderTotal,
        this.orderShippingCharge,
        this.orderKey,
        this.orderMessage,
        this.orderDate,
        this.orderByPrescription,
        this.orderByPrescriptionImage,
        this.orderStatus,
        this.orderCDT,
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
        this.addressFullName,
        this.addressMobileNo,
        this.addressColony,
        this.addressLandmark,
        this.addressType,
        this.stateId,
        this.cityId,
        this.addressAlternativeNo,
        this.addressPincode,
        this.addressDefault,
        this.addressStatus,
        this.addressCDT});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderId'];
    firmId = json['FirmId'];
    customerId = json['CustomerId'];
    addressId = json['AddressId'];
    ordertrackingLink = json['OrdertrackingLink'];
    orderDoctorName = json['OrderDoctorName'];
    orderPaymentMethod = json['OrderPaymentMethod'];
    orderTransactionNo = json['OrderTransactionNo'];
    orderStageDropDown = json['OrderStageDropDown'];
    orderItemsProcessingDate = json['OrderItemsProcessingDate'];
    orderDeliveringDate = json['OrderDeliveringDate'];
    orderDeliveredDate = json['OrderDeliveredDate'];
    orderDeliveryDate = json['OrderDeliveryDate'];
    orderCancelDate = json['OrderCancelDate'];
    orderGST = json['OrderGST'];
    orderSubTotal = json['OrderSubTotal'];
    orderPointsType = json['OrderPointsType'];
    orderTotalPoints = json['OrderTotalPoints'];
    orderTotal = json['OrderTotal'];
    orderShippingCharge = json['OrderShippingCharge'];
    orderKey = json['OrderKey'];
    orderMessage = json['OrderMessage'];
    orderDate = json['OrderDate'];
    orderByPrescription = json['OrderByPrescription'];
    orderByPrescriptionImage = json['OrderByPrescriptionImage'];
    orderStatus = json['OrderStatus'];
    orderCDT = json['OrderCDT'];
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
    addressFullName = json['AddressFullName'];
    addressMobileNo = json['AddressMobileNo'];
    addressColony = json['AddressColony'];
    addressLandmark = json['AddressLandmark'];
    addressType = json['AddressType'];
    stateId = json['StateId'];
    cityId = json['CityId'];
    addressAlternativeNo = json['AddressAlternativeNo'];
    addressPincode = json['AddressPincode'];
    addressDefault = json['AddressDefault'];
    addressStatus = json['AddressStatus'];
    addressCDT = json['AddressCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderId'] = this.orderId;
    data['FirmId'] = this.firmId;
    data['CustomerId'] = this.customerId;
    data['AddressId'] = this.addressId;
    data['OrdertrackingLink'] = this.ordertrackingLink;
    data['OrderDoctorName'] = this.orderDoctorName;
    data['OrderPaymentMethod'] = this.orderPaymentMethod;
    data['OrderTransactionNo'] = this.orderTransactionNo;
    data['OrderStageDropDown'] = this.orderStageDropDown;
    data['OrderItemsProcessingDate'] = this.orderItemsProcessingDate;
    data['OrderDeliveringDate'] = this.orderDeliveringDate;
    data['OrderDeliveredDate'] = this.orderDeliveredDate;
    data['OrderDeliveryDate'] = this.orderDeliveryDate;
    data['OrderCancelDate'] = this.orderCancelDate;
    data['OrderGST'] = this.orderGST;
    data['OrderSubTotal'] = this.orderSubTotal;
    data['OrderPointsType'] = this.orderPointsType;
    data['OrderTotalPoints'] = this.orderTotalPoints;
    data['OrderTotal'] = this.orderTotal;
    data['OrderShippingCharge'] = this.orderShippingCharge;
    data['OrderKey'] = this.orderKey;
    data['OrderMessage'] = this.orderMessage;
    data['OrderDate'] = this.orderDate;
    data['OrderByPrescription'] = this.orderByPrescription;
    data['OrderByPrescriptionImage'] = this.orderByPrescriptionImage;
    data['OrderStatus'] = this.orderStatus;
    data['OrderCDT'] = this.orderCDT;
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
    data['AddressFullName'] = this.addressFullName;
    data['AddressMobileNo'] = this.addressMobileNo;
    data['AddressColony'] = this.addressColony;
    data['AddressLandmark'] = this.addressLandmark;
    data['AddressType'] = this.addressType;
    data['StateId'] = this.stateId;
    data['CityId'] = this.cityId;
    data['AddressAlternativeNo'] = this.addressAlternativeNo;
    data['AddressPincode'] = this.addressPincode;
    data['AddressDefault'] = this.addressDefault;
    data['AddressStatus'] = this.addressStatus;
    data['AddressCDT'] = this.addressCDT;
    return data;
  }
}