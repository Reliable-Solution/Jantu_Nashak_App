class CartTotal {
  int? razorpayTotal;
  int? totalInteger;
  int? razorpaySubTotal;
  String? subtotal;
  String? save;
  String? deliveryCharge;
  String? total;
  String? description;
  String? getPointsDescription;
  int? reedemPoints;
  String? deliveryMsg;
  String? minCartValueToReedemPointDesc;
  int? minCartValueToReedemPoint;

  CartTotal(
      {this.razorpayTotal,
        this.totalInteger,
        this.razorpaySubTotal,
        this.subtotal,
        this.save,
        this.deliveryCharge,
        this.total,
        this.description,
        this.getPointsDescription,
        this.reedemPoints,
        this.deliveryMsg,
        this.minCartValueToReedemPointDesc,
        this.minCartValueToReedemPoint});

  CartTotal.fromJson(Map<String, dynamic> json) {
    razorpayTotal = json['RazorpayTotal'];
    totalInteger = json['TotalInteger'];
    razorpaySubTotal = json['RazorpaySubTotal'];
    subtotal = json['Subtotal'];
    save = json['Save'];
    deliveryCharge = json['DeliveryCharge'];
    total = json['Total'];
    description = json['Description'];
    getPointsDescription = json['GetPointsDescription'];
    reedemPoints = json['ReedemPoints'];
    deliveryMsg = json['DeliveryMsg'];
    minCartValueToReedemPointDesc = json['MinCartValueToReedemPointDesc'];
    minCartValueToReedemPoint = json['MinCartValueToReedemPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RazorpayTotal'] = this.razorpayTotal;
    data['TotalInteger'] = this.totalInteger;
    data['RazorpaySubTotal'] = this.razorpaySubTotal;
    data['Subtotal'] = this.subtotal;
    data['Save'] = this.save;
    data['DeliveryCharge'] = this.deliveryCharge;
    data['Total'] = this.total;
    data['Description'] = this.description;
    data['GetPointsDescription'] = this.getPointsDescription;
    data['ReedemPoints'] = this.reedemPoints;
    data['DeliveryMsg'] = this.deliveryMsg;
    data['MinCartValueToReedemPointDesc'] = this.minCartValueToReedemPointDesc;
    data['MinCartValueToReedemPoint'] = this.minCartValueToReedemPoint;
    return data;
  }
}