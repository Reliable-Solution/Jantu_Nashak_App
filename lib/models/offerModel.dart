class OfferModel {
  String? offerId;
  String? offerCode;
  String? offerPriority;
  String? offerImage;
  String? offerStatus;
  String? offerCDT;

  OfferModel(
      {this.offerId,
        this.offerCode,
        this.offerPriority,
        this.offerImage,
        this.offerStatus,
        this.offerCDT});

  OfferModel.fromJson(Map<String, dynamic> json) {
    offerId = json['OfferId'];
    offerCode = json['OfferCode'];
    offerPriority = json['OfferPriority'];
    offerImage = json['OfferImage'];
    offerStatus = json['OfferStatus'];
    offerCDT = json['OfferCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OfferId'] = this.offerId;
    data['OfferCode'] = this.offerCode;
    data['OfferPriority'] = this.offerPriority;
    data['OfferImage'] = this.offerImage;
    data['OfferStatus'] = this.offerStatus;
    data['OfferCDT'] = this.offerCDT;
    return data;
  }
}