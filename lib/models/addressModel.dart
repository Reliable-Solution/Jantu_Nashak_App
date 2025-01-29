class AddressModel {
  String? addressId;
  String? customerId;
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
  String? stateName;
  String? stateStatus;
  String? stateCDT;
  String? cityName;
  String? cityStatus;
  String? cityCDT;

  AddressModel(
      {this.addressId,
        this.customerId,
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
        this.addressCDT,
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
        this.stateName,
        this.stateStatus,
        this.stateCDT,
        this.cityName,
        this.cityStatus,
        this.cityCDT});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['AddressId'];
    customerId = json['CustomerId'];
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
    stateName = json['StateName'];
    stateStatus = json['StateStatus'];
    stateCDT = json['StateCDT'];
    cityName = json['CityName'];
    cityStatus = json['CityStatus'];
    cityCDT = json['CityCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AddressId'] = this.addressId;
    data['CustomerId'] = this.customerId;
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
    data['StateName'] = this.stateName;
    data['StateStatus'] = this.stateStatus;
    data['StateCDT'] = this.stateCDT;
    data['CityName'] = this.cityName;
    data['CityStatus'] = this.cityStatus;
    data['CityCDT'] = this.cityCDT;
    return data;
  }
}