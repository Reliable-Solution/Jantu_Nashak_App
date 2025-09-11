class CustomerModel {
  String? customerId;
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
  String? points;

  CustomerModel(
      {this.customerId,
      this.customerName,
      this.customerImage,
      this.customerEmailId,
      this.customerGender,
      this.customerFCMToken,
      this.customerPhoneNo,
      this.customerCode,
      this.customerReferCode,
      this.customerStatus,
      this.points,
      this.customerCDT});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['CustomerId'];
    customerName = json['CustomerName'];
    customerImage = json['CustomerImage'];
    customerEmailId = json['CustomerEmailId'];
    customerGender = json['CustomerGender'];
    customerFCMToken = json['CustomerFCMToken'];
    customerPhoneNo = json['CustomerPhoneNo'];
    customerCode = json['CustomerCode'];
    customerReferCode = json['CustomerReferCode'];
    customerStatus = json['CustomerStatus'];
    points = json['Points'];
    customerCDT = json['CustomerCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerId'] = this.customerId;
    data['CustomerName'] = this.customerName;
    data['CustomerImage'] = this.customerImage;
    data['CustomerEmailId'] = this.customerEmailId;
    data['CustomerGender'] = this.customerGender;
    data['CustomerFCMToken'] = this.customerFCMToken;
    data['CustomerPhoneNo'] = this.customerPhoneNo;
    data['CustomerCode'] = this.customerCode;
    data['CustomerReferCode'] = this.customerReferCode;
    data['CustomerStatus'] = this.customerStatus;
    data['Points'] = this.points;
    data['CustomerCDT'] = this.customerCDT;
    return data;
  }
}
