class BrandModel {
  String? brandId;
  String? brandName;
  String? brandDescription;
  String? brandImage;
  String? brandStatus;
  String? brandCDT;

  BrandModel(
      {this.brandId,
        this.brandName,
        this.brandDescription,
        this.brandImage,
        this.brandStatus,
        this.brandCDT});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json['BrandId'];
    brandName = json['BrandName'];
    brandDescription = json['BrandDescription'];
    brandImage = json['BrandImage'];
    brandStatus = json['BrandStatus'];
    brandCDT = json['BrandCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BrandId'] = this.brandId;
    data['BrandName'] = this.brandName;
    data['BrandDescription'] = this.brandDescription;
    data['BrandImage'] = this.brandImage;
    data['BrandStatus'] = this.brandStatus;
    data['BrandCDT'] = this.brandCDT;
    return data;
  }
}