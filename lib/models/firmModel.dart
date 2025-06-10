class FirmModel {
  bool? isSuccess;
  String? message;
  List<FirmInfo>? data;

  FirmModel({this.isSuccess, this.message, this.data});

  FirmModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <FirmInfo>[];
      json['Data'].forEach((v) {
        data!.add(FirmInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['IsSuccess'] = this.isSuccess;
    map['Message'] = this.message;
    if (this.data != null) {
      map['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class FirmInfo {
  String? firmId;
  String? firmName;
  String? firmLogo;
  String? firmEmailId;
  String? firmImage;
  String? firmFirstLineAddress;
  String? firmSecondAddress;
  String? firmGSTNo;
  String? firmDrugLicenceNo;
  String? firmGodname;
  String? firmPhoneNo;
  String? firmStatus;
  String? firmCDT;

  FirmInfo({
    this.firmId,
    this.firmName,
    this.firmLogo,
    this.firmEmailId,
    this.firmImage,
    this.firmFirstLineAddress,
    this.firmSecondAddress,
    this.firmGSTNo,
    this.firmDrugLicenceNo,
    this.firmGodname,
    this.firmPhoneNo,
    this.firmStatus,
    this.firmCDT,
  });

  FirmInfo.fromJson(Map<String, dynamic> json) {
    firmId = json['FirmId'];
    firmName = json['FirmName'];
    firmLogo = json['FirmLogo'];
    firmEmailId = json['FirmEmailId'];
    firmImage = json['FirmImage'];
    firmFirstLineAddress = json['FirmFirstLineAddress'];
    firmSecondAddress = json['FirmSecondAddress'];
    firmGSTNo = json['FirmGSTNo'];
    firmDrugLicenceNo = json['FirmDrugLicenceNo'];
    firmGodname = json['FirmGodname'];
    firmPhoneNo = json['FirmPhoneNo'];
    firmStatus = json['FirmStatus'];
    firmCDT = json['FirmCDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['FirmId'] = this.firmId;
    map['FirmName'] = this.firmName;
    map['FirmLogo'] = this.firmLogo;
    map['FirmEmailId'] = this.firmEmailId;
    map['FirmImage'] = this.firmImage;
    map['FirmFirstLineAddress'] = this.firmFirstLineAddress;
    map['FirmSecondAddress'] = this.firmSecondAddress;
    map['FirmGSTNo'] = this.firmGSTNo;
    map['FirmDrugLicenceNo'] = this.firmDrugLicenceNo;
    map['FirmGodname'] = this.firmGodname;
    map['FirmPhoneNo'] = this.firmPhoneNo;
    map['FirmStatus'] = this.firmStatus;
    map['FirmCDT'] = this.firmCDT;
    return map;
  }
}
