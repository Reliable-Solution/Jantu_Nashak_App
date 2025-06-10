class FaqModel {
  bool? isSuccess;
  String? message;
  List<FaqModelData>? faqModelData;

  FaqModel({this.isSuccess, this.message, this.faqModelData});

  FaqModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Data'] != null) {
      faqModelData = <FaqModelData>[];
      json['Data'].forEach((v) {
        faqModelData!.add(new FaqModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.faqModelData != null) {
      data['Data'] = this.faqModelData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqModelData {
  String? modulesId;
  String? modulesTitle;
  String? modulesImageLink;
  String? modulesDescription;
  String? modulesType;
  String? modulesStatus;
  String? modulesCDT;

  FaqModelData(
      {this.modulesId,
        this.modulesTitle,
        this.modulesImageLink,
        this.modulesDescription,
        this.modulesType,
        this.modulesStatus,
        this.modulesCDT});

  FaqModelData.fromJson(Map<String, dynamic> json) {
    modulesId = json['FaqId'];
    modulesTitle = json['FaqQuestion'];
    modulesImageLink = json['FaqAnswer'];
    modulesDescription = json['FaqAnswer'];
    modulesType = json['FaqFaqTypeStatus'];
    modulesStatus = json['FaqStatus'];
    modulesCDT = json['FaqCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FaqId'] = this.modulesId;
    data['FaqQuestion'] = this.modulesTitle;
    data['FaqAnswer'] = this.modulesImageLink;
    data['FaqAnswer'] = this.modulesDescription;
    data['FaqFaqTypeStatus'] = this.modulesType;
    data['FaqStatus'] = this.modulesStatus;
    data['FaqCDT'] = this.modulesCDT;
    return data;
  }
}